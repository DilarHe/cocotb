import numpy as np
from numfi import numfi
import torch
import os
from FFT import qFFT
from numpy.lib.stride_tricks import as_strided
from numpy.typing import ArrayLike, DTypeLike
from typing import (
    Any,
    Callable,
    Iterable,
    List,
    Dict,
    Optional,
    Sequence,
    Tuple,
    TypeVar,
    Union,
    overload,
)
import json

def load_json_config(json_path):
    with open(json_path, 'r') as f:
        config = json.load(f)
    return config

MAX_MEM_BLOCK = 2**8 * 2**10

def write_list_to_file(file_path, list_data):
    with open(file_path, 'w') as f:
        for i in range(len(list_data)):
            if i == len(list_data)-1:
                f.write(str(list_data[i]))
            else:
                f.write(str(list_data[i]) + '\n')

class LibrosaError(Exception):
    """The root librosa exception class"""

    pass


class ParameterError(LibrosaError):
    """Exception class for mal-formed inputs"""

    pass

def dtype_r2c(d: DTypeLike, *, default: Optional[type] = np.complex64) -> DTypeLike:
    """Find the complex numpy dtype corresponding to a real dtype.

    This is used to maintain numerical precision and memory footprint
    when constructing complex arrays from real-valued data
    (e.g. in a Fourier transform).

    A `float32` (single-precision) type maps to `complex64`,
    while a `float64` (double-precision) maps to `complex128`.

    Parameters
    ----------
    d : np.dtype
        The real-valued dtype to convert to complex.
        If ``d`` is a complex type already, it will be returned.
    default : np.dtype, optional
        The default complex target type, if ``d`` does not match a
        known dtype

    Returns
    -------
    d_c : np.dtype
        The complex dtype

    See Also
    --------
    dtype_c2r
    numpy.dtype

    Examples
    --------
    >>> librosa.util.dtype_r2c(np.float32)
    dtype('complex64')

    >>> librosa.util.dtype_r2c(np.int16)
    dtype('complex64')

    >>> librosa.util.dtype_r2c(np.complex128)
    dtype('complex128')
    """
    mapping: Dict[DTypeLike, type] = {
        np.dtype(np.float32): np.complex64,
        np.dtype(np.float64): np.complex128,
        np.dtype(float): np.dtype(complex).type,
    }

    # If we're given a complex type already, return it
    dt = np.dtype(d)
    if dt.kind == "c":
        return dt

    # Otherwise, try to map the dtype.
    # If no match is found, return the default.
    return np.dtype(mapping.get(dt, default))
               
def util_frame(
    x: np.ndarray,
    *,
    frame_length: int,
    hop_length: int,
    axis: int = -1,
    writeable: bool = False,
    subok: bool = False,
) -> np.ndarray:
    """Slice a data array into (overlapping) frames.

    This implementation uses low-level stride manipulation to avoid
    making a copy of the data.  The resulting frame representation
    is a new view of the same input data.

    For example, a one-dimensional input ``x = [0, 1, 2, 3, 4, 5, 6]``
    can be framed with frame length 3 and hop length 2 in two ways.
    The first (``axis=-1``), results in the array ``x_frames``::

        [[0, 2, 4],
         [1, 3, 5],
         [2, 4, 6]]

    where each column ``x_frames[:, i]`` contains a contiguous slice of
    the input ``x[i * hop_length : i * hop_length + frame_length]``.

    The second way (``axis=0``) results in the array ``x_frames``::

        [[0, 1, 2],
         [2, 3, 4],
         [4, 5, 6]]

    where each row ``x_frames[i]`` contains a contiguous slice of the input.

    This generalizes to higher dimensional inputs, as shown in the examples below.
    In general, the framing operation increments by 1 the number of dimensions,
    adding a new "frame axis" either before the framing axis (if ``axis < 0``)
    or after the framing axis (if ``axis >= 0``).

    Parameters
    ----------
    x : np.ndarray
        Array to frame
    frame_length : int > 0 [scalar]
        Length of the frame
    hop_length : int > 0 [scalar]
        Number of steps to advance between frames
    axis : int
        The axis along which to frame.
    writeable : bool
        If ``True``, then the framed view of ``x`` is read-only.
        If ``False``, then the framed view is read-write.  Note that writing to the framed view
        will also write to the input array ``x`` in this case.
    subok : bool
        If True, sub-classes will be passed-through, otherwise the returned array will be
        forced to be a base-class array (default).

    Returns
    -------
    x_frames : np.ndarray [shape=(..., frame_length, N_FRAMES, ...)]
        A framed view of ``x``, for example with ``axis=-1`` (framing on the last dimension)::

            x_frames[..., j] == x[..., j * hop_length : j * hop_length + frame_length]

        If ``axis=0`` (framing on the first dimension), then::

            x_frames[j] = x[j * hop_length : j * hop_length + frame_length]

    Raises
    ------
    ParameterError
        If ``x.shape[axis] < frame_length``, there is not enough data to fill one frame.

        If ``hop_length < 1``, frames cannot advance.

    See Also
    --------
    numpy.lib.stride_tricks.as_strided

    Examples
    --------
    Extract 2048-sample frames from monophonic signal with a hop of 64 samples per frame

    >>> y, sr = librosa.load(librosa.ex('trumpet'))
    >>> frames = librosa.util.frame(y, frame_length=2048, hop_length=64)
    >>> frames
    array([[-1.407e-03, -2.604e-02, ..., -1.795e-05, -8.108e-06],
           [-4.461e-04, -3.721e-02, ..., -1.573e-05, -1.652e-05],
           ...,
           [ 7.960e-02, -2.335e-01, ..., -6.815e-06,  1.266e-05],
           [ 9.568e-02, -1.252e-01, ...,  7.397e-06, -1.921e-05]],
          dtype=float32)
    >>> y.shape
    (117601,)

    >>> frames.shape
    (2048, 1806)

    Or frame along the first axis instead of the last:

    >>> frames = librosa.util.frame(y, frame_length=2048, hop_length=64, axis=0)
    >>> frames.shape
    (1806, 2048)

    Frame a stereo signal:

    >>> y, sr = librosa.load(librosa.ex('trumpet', hq=True), mono=False)
    >>> y.shape
    (2, 117601)
    >>> frames = librosa.util.frame(y, frame_length=2048, hop_length=64)
    (2, 2048, 1806)

    Carve an STFT into fixed-length patches of 32 frames with 50% overlap

    >>> y, sr = librosa.load(librosa.ex('trumpet'))
    >>> S = np.abs(librosa.stft(y))
    >>> S.shape
    (1025, 230)
    >>> S_patch = librosa.util.frame(S, frame_length=32, hop_length=16)
    >>> S_patch.shape
    (1025, 32, 13)
    >>> # The first patch contains the first 32 frames of S
    >>> np.allclose(S_patch[:, :, 0], S[:, :32])
    True
    >>> # The second patch contains frames 16 to 16+32=48, and so on
    >>> np.allclose(S_patch[:, :, 1], S[:, 16:48])
    True
    """

    # This implementation is derived from numpy.lib.stride_tricks.sliding_window_view (1.20.0)
    # https://numpy.org/doc/stable/reference/generated/numpy.lib.stride_tricks.sliding_window_view.html

    x = np.array(x, copy=False, subok=subok)

    if x.shape[axis] < frame_length:
        raise ParameterError(
            f"Input is too short (n={x.shape[axis]:d}) for frame_length={frame_length:d}"
        )

    if hop_length < 1:
        raise ParameterError(f"Invalid hop_length: {hop_length:d}")

    # put our new within-frame axis at the end for now
    out_strides = x.strides + tuple([x.strides[axis]])

    # Reduce the shape on the framing axis
    x_shape_trimmed = list(x.shape)
    x_shape_trimmed[axis] -= frame_length - 1

    out_shape = tuple(x_shape_trimmed) + tuple([frame_length])
    xw = as_strided(
        x, strides=out_strides, shape=out_shape, subok=subok, writeable=writeable
    )

    if axis < 0:
        target_axis = axis - 1
    else:
        target_axis = axis + 1

    xw = np.moveaxis(xw, -1, target_axis)

    # Downsample along the target axis
    slices = [slice(None)] * xw.ndim
    slices[axis] = slice(0, None, hop_length)
    return xw[tuple(slices)]

def my_stft_nowindow(
        y_frames,
        n_fft=2048,
        dtype=None,
        fft_handle=None,
):
    if dtype is None:
        dtype = dtype_r2c(y_frames.dtype)
    stft_matrix = np.empty(
        (int(1 + n_fft // 2), y_frames.shape[1]), dtype=dtype, order="F"
    )
    # fft = librosa.get_fftlib()
    fft = fft_handle
    n_columns = MAX_MEM_BLOCK // (stft_matrix.shape[0] * stft_matrix.itemsize)
    n_columns = max(n_columns, 1)

    for bl_s in range(0, stft_matrix.shape[1], n_columns):
        bl_t = min(bl_s + n_columns, stft_matrix.shape[1])

        stft_matrix[:, bl_s:bl_t]  = fft(
            y_frames[:, bl_s:bl_t], rfft=True
        )
        # stft_matrix[:, bl_s:bl_t] = fft.rfft(
        #     fft_window * y_frames[:, bl_s:bl_t], axis=0
        # )
    return stft_matrix

def frame_window(
        y,
        n_fft=2048,
        hop_length=None,
        center=False,
        pad_mode="reflect",
        window = None,
):
    # Check audio is valid
    if (center):
        y = np.pad(y, int(n_fft // 2), mode=pad_mode)
    # Window the time series.
    y_frames = util_frame(y, frame_length=n_fft, hop_length=hop_length)
    y_frames = window * y_frames
    return y_frames

# -----------------------------------------------------------------------
# --------------  上面是librosa中的库函数， 下面是主体代码  ------------------
# -----------------------------------------------------------------------

def window_param_gen(NFFT=256):
    qfft_window_uint8 = np.round(torch.hann_window(NFFT).reshape(NFFT,1).numpy() * 255).astype(np.uint8)
    with open('../../../rom_data/win_rom.txt', 'w') as f:
        for i in range(qfft_window_uint8.flatten().shape[0]):
            if i == qfft_window_uint8.flatten().shape[0]-1:
                f.write("%d"%qfft_window_uint8.flatten()[i])
            else:
                f.write("%d\n"%qfft_window_uint8.flatten()[i])
    with open('win_rom.txt', 'w') as f:
        for i in range(qfft_window_uint8.flatten().shape[0]):
            if i == qfft_window_uint8.flatten().shape[0]-1:
                f.write("%d"%qfft_window_uint8.flatten()[i])
            else:
                f.write("%d\n"%qfft_window_uint8.flatten()[i])
    return
    
def mel_filter_gen():
    mel_filter = np.zeros([30,129], dtype=np.int32)
    mel_filter[0, 3:6] = [82, 243,67]
    mel_filter[1, 4:7] = [12, 188,152]
    mel_filter[2, 6:9] = [103, 240,82]
    mel_filter[3, 7:11] = [15,173,183,33]
    mel_filter[4, 9:13] = [72,222,144,2]
    mel_filter[5, 11:14] = [111,253,122]
    mel_filter[6, 13:16] = [133,243,115]
    mel_filter[7, 14:19] = [12,140,243,122,1]
    mel_filter[8, 16:21] = [12,133,254,141,27]
    mel_filter[9, 19:23] = [114,228,171,63]
    mel_filter[10, 21:26] = [84,192,211,108,5]
    mel_filter[11, 23:28] = [44,147,250,162,64]
    mel_filter[12, 26:31] = [93,191,223,131,38]
    mel_filter[13, 28:34] = [32,124,217,203,115,28]
    mel_filter[14, 31:37] = [52,140,227,198,115,31]

    mel_filter[15, 34:40] = [57,140,224,206,127,48]
    mel_filter[16, 37:44] = [49,128,207,226,151,76,1]
    mel_filter[17, 40:47] = [29,104,179,254,186,115,44]
    mel_filter[18, 44:51] = [69,140,211,229,162,95,28]
    mel_filter[19, 47:55] = [26,93,160,227,218,154,90,27]
    mel_filter[20, 51:59] = [37,101,165,228,220,159,99,39]
    mel_filter[21, 55:64] = [35,96,156,216,234,177,120,63,6]
    mel_filter[22, 59:68] = [21,78,135,192,249,206,152,98,43]
    mel_filter[23, 64:73] = [49,103,157,212,245,193,142,90,39]
    mel_filter[24, 68:78] = [10,62,113,165,216,243,194,146,97,48]
    mel_filter[25, 73:84] = [12,61,109,158,207,255,208,162,116,70,24]
    mel_filter[26, 79:90] = [47,93,139,185,231,234,190,146,102,58,15]
    mel_filter[27, 84:96] = [21,65,109,153,197,240,227,186,144,103,61,20]
    mel_filter[28, 90:102] = [28,69,111,152,194,235,235,195,156,117,77,38]
    mel_filter[29, 96:109] = [20,60,99,138,178,217,254,216,179,142,104,67,30]

    return mel_filter

def prepare_mel_rom_v2(mel_filter_q, indexLenWidth = 4, rompath = './'):
    mel_data = []
    mel_index = []
    for i in range(mel_filter_q.shape[0]):
        index = np.where(mel_filter_q[i] != 0)[0].tolist()
        true = mel_filter_q[i][index]
        index_start = index[0]
        index_len = len(index)
        mel_data.extend(true)
        mel_index.append(index_start*2**indexLenWidth + index_len)
    write_list_to_file(os.path.join(rompath, 'mel_data_rom.txt'), mel_data)
    write_list_to_file(os.path.join(rompath, 'mel_index_rom.txt'), mel_index)
    return mel_data, mel_index

def write_mel_data_to_file():
    mel_filter_q = mel_filter_gen()
    _,_ = prepare_mel_rom_v2(mel_filter_q, rompath='../../../rom_data/')
    np.savetxt('mel_filter.txt', mel_filter_q,fmt='%d')
    return


class FixedCordic():
    def __init__(self, qinput=None, qoutput= None, qcoeff=(0, 8, 8), iter_index=np.arange(16)):
        self.s_in, self.w_in, self.f_in = qinput
        if qoutput is not None:
            self.s_out, self.w_out, self.f_out = qoutput
        self.s_coef, self.w_coef, self.f_coef = qcoeff
        self.iter_index = iter_index
        self.iter_num = np.array(iter_index).shape[0] + 1
        self.width_add = int(np.log(self.iter_num) / np.log(2))

        self.mode_dict = {'circle': 0, 'liner': 1, 'hyperbolic': 2}

        e1 = np.arctan(np.power(0.5, iter_index))
        e2 = np.power(0.5, iter_index)
        ## for log and e
        neg_e = np.array(iter_index)[np.where(np.array(iter_index) <= 0)]
        e3_p1 = np.arctanh(1 - np.power(0.5, -neg_e + 2))
        pos_e = np.array(iter_index)[np.where(np.array(iter_index) > 0)]
        e3_p2 = np.arctanh(np.power(0.5, pos_e))
        e3 = np.concatenate((e3_p1, e3_p2))
        e3_fixed = numfi(e3, self.s_coef, self.w_coef, self.f_coef)
        e2_fixed = numfi(e2, self.s_coef, self.w_coef, self.f_coef)
        e1_fixed = numfi(e1, self.s_coef, self.w_coef, self.f_coef)

        self.e = {'circle': e1_fixed, 'liner': e2_fixed, 'hyperbolic': e3_fixed}
        self.u = {'circle': numfi(1, 0, 1, 0), 'liner': numfi(0, 0, 1, 0), 'hyperbolic': numfi(-1, 1, 1, 0)}
        
        if neg_e.shape[0] == 0:
            k1 = 1 / np.cumprod(np.power(1 + np.power(0.25, iter_index), 0.5))[-1]
            k2 = 1 / np.cumprod(np.power(1 - np.power(0.25, iter_index), 0.5))[-1]
            k1_fixed = np.array(numfi(k1, self.s_coef, self.w_coef, self.f_coef))
            k2_fixed = np.array(numfi(k2, self.s_coef, self.w_coef, self.f_coef))
        else: # should be hyperbolic
            k1_fixed = None
            k2_fixed = None

        # for exp
        k3 = 1 / (np.cumprod(np.power(1 - np.power(1 - np.power(0.5, -neg_e + 2), 2), 0.5))[-1] * np.cumprod(np.power(1 - np.power(0.25, pos_e), 0.5))[-1])
        k3_fixed = np.array(numfi(k3, self.s_coef, self.w_coef, self.f_coef))
        self.k = {'circle': k1_fixed, 'liner': k1_fixed, 'hyperbolic': k2_fixed, 'e': k3_fixed}

    def save_e(self, save_path, mode):
        elist = np.array(self.e[mode]) * (2**self.f_coef)
        elist = np.array(elist, dtype = np.int32).tolist()
        write_list_to_file(save_path, elist)
        
    def sign(self, in_np):  # avoid sign(0) = 0
        return np.sign(np.sign(np.array(in_np)) + 0.1)

    def mag(self, x0, y0):
        # self.width_add = 0
        cal_shape = np.append(np.array(self.iter_num), np.array(x0.shape))
        x = numfi(np.zeros(cal_shape), self.s_in, self.w_in + self.width_add, self.f_in)
        y = numfi(np.zeros(cal_shape), self.s_in, self.w_in + self.width_add, self.f_in)
        z = numfi(np.zeros(cal_shape), self.s_in, self.w_in + self.width_add, self.f_in)
        z0 = 0
        mode = 'circle'
        d = self.sign
        u_true = self.u[mode]
        e_true = self.e[mode]
        k_true = self.k[mode]
        x[0] = numfi(x0, self.s_in, self.w_in, self.f_in)
        y[0] = numfi(y0, self.s_in, self.w_in, self.f_in)
        z[0] = numfi(z0, self.s_in, self.w_in, self.f_in)
        for i, index in enumerate(self.iter_index):
            di = numfi(-(d(x[i]) * d(y[i])), 1, 2, 0)  # -d(xi*yi)

            yi = y[i] >> index
            xi = x[i] >> index

            x[i + 1] = x[i] - u_true * di * yi
            y[i + 1] = y[i] + di * xi

        return np.array(numfi(x[-1] * (k_true), self.s_in, self.w_in + 1, self.f_in))
    
    def exp(self, x_in):
        self.width_add = 4
        cal_shape = np.append(np.array(self.iter_num), np.array(x_in.shape))
        x = numfi(np.zeros(cal_shape), self.s_in, self.w_in + self.width_add, self.f_in)
        y = numfi(np.zeros(cal_shape), self.s_in, self.w_in + self.width_add, self.f_in)
        z = numfi(np.zeros(cal_shape), self.s_in, self.w_in + self.width_add, self.f_in)
    
        mode = 'hyperbolic'
        d = self.sign
        u_true = self.u[mode]
        e_true = self.e[mode]
        k_true = self.k['e']
        print(k_true)
        x0 = k_true * np.ones(x_in.shape)
        y0 = k_true * np.ones(x_in.shape)
        z0 = x_in
        x[0] = numfi(x0, self.s_in, self.w_in + self.width_add, self.f_in)
        y[0] = numfi(y0, self.s_in, self.w_in + self.width_add, self.f_in)
        z[0] = numfi(z0, self.s_in, self.w_in + self.width_add, self.f_in)
        for i, index in enumerate(self.iter_index):
            di = numfi(d(z[i]), 1, 2, 0)
            if index <= 0:
                yi = y[i] - (y[i] >> (2 - index))
                xi = x[i] - (x[i] >> (2 - index))
                # print(yi)
            else:
                yi = y[i] >> index
                xi = x[i] >> index
       
            z[i + 1] = z[i] - di * e_true[i]
            x[i + 1] = x[i] - u_true * di * yi
            y[i + 1] = y[i] + di * xi
        # print([x])
        return np.array(numfi(x[-1], self.s_out, self.w_out, self.f_out))
 
    def ln(self, x_in):
        self.width_add = 4
        cal_shape = np.append(np.array(self.iter_num), np.array(x_in.shape))
        x = numfi(np.zeros(cal_shape), self.s_in, self.w_in + self.width_add, self.f_in)
        y = numfi(np.zeros(cal_shape), self.s_in, self.w_in + self.width_add, self.f_in)
        z = numfi(np.zeros(cal_shape), self.s_coef, self.w_coef + self.width_add, self.f_coef)
        x0 = x_in + 1
        y0 = x_in - 1
        z0 = 0
        mode = 'hyperbolic'
        d = self.sign
        u_true = self.u[mode]
        e_true = self.e[mode]
        x[0] = numfi(x0, self.s_in, self.w_in + self.width_add, self.f_in)
        y[0] = numfi(y0, self.s_in, self.w_in + self.width_add, self.f_in)
        z[0] = numfi(z0, self.s_coef, self.w_coef + self.width_add, self.f_coef)
        # print(np.array(x[0]) * 2**self.f_in)
        # print(np.array(y[0]) * 2**self.f_in)
        for i, index in enumerate(self.iter_index):
            di = numfi(-d(y[i]), 1, 2, 0)
            if index <= 0:
                yi = y[i] - (y[i] >> (2-index))
                xi = x[i] - (x[i] >> (2-index))
            else:
                yi = y[i] >> index
                xi = x[i] >> index
            # print(f"{i}, x====")
            # print(xi.s, xi.w, xi.f)          
            # print(yi.s, yi.w, yi.f)

            # print(np.array(xi[0]) * 2**14)
            # print(np.array(yi[0]) * 2**14)
            
            z[i + 1] = z[i] - di * e_true[i]
            x[i + 1] = x[i] - u_true * di * yi
            y[i + 1] = y[i] + di * xi
            # print("ccc====")
            # print(z.s, z.w, z.f)
            # print(x[i + 1].s, x[i + 1].w, x[i + 1].f)
            # print(np.array(x[i+1,0]) * 2**self.f_in)
            # print(np.array(y[i+1,0]) * 2**self.f_in)
            # print(np.array(z[i+1,0]) * 2**self.f_coef)
            # for ii in z[i,0]:
            #     print("{:.15f}".format(float(ii)))
        # print([x])
        tmp = z[-1] * numfi(2, 0,2,0)
        # print("========================")
        # print(tmp.s,  tmp.w, tmp.f)
        # print(np.array(tmp)*2**self.f_in)
        return np.array(numfi(tmp, self.s_out, self.w_out, self.f_out))


def lp_fliter_func(x0,x1,x2):
    a1 = 38/256
    a2 = 74/256
    b0 = 166/256
    b1 = 137/256
    b2 = 64/256

    return b0 * x0 + b1 * x1 + b2 * x2 - a1 * x1 - a2 * x2

def lp_filter(y):
    a1 = 38/256
    a2 = 74/256
    b0 = 166/256
    b1 = 137/256
    b2 = 64/256
    wav = y.flatten()
    wav_16k_filter = np.zeros([wav.shape[0]])
    for i in range(wav.shape[0]-2):
        wav_16k_filter[i+2] = b0 * wav[i+2] + b1 * wav[i+1] + b2 * wav[i] - \
                              a1 * wav[i+1] - a2 * wav[i]
        # print(wav[i+2]*2**15,wav[i+1]*2**15,wav[i]*2**15)
        # print(wav_16k_filter[i+2]*2**23)
        # raise("!")
    wav_8k_filter = wav_16k_filter[0:-1:2]
    return wav_16k_filter, wav_8k_filter


def window(NFFT, hop_length, filter8K, quot):
    qfft_window_uint8 = np.loadtxt("win_rom.txt").astype(np.int32).reshape(NFFT,1)
    qfft_window = qfft_window_uint8 / 256
    frams = frame_window(filter8K, n_fft=NFFT, hop_length=hop_length, center=False, pad_mode="reflect", window=qfft_window)
    frams = np.array(numfi(frams, quot[0],quot[1],quot[2]))
    return frams

def vad(pcm_hops, threshold, hangover):
    count_tail = 0
    hop_num = pcm_hops.shape[1]
    vad_flag = np.zeros([hop_num], np.int32)
    pcm_hop_abs = np.abs(pcm_hops)
    energy = np.sum(pcm_hop_abs, axis=0)
    true_thre = (int(threshold) << 8)
    for i in range(hop_num):
        if energy[i] >= true_thre:
            vad_flag[i] = 1
            count_tail = hangover
        else:
            vad_flag[i] = 0
            if(count_tail > 0):
                vad_flag[i] = 1
                count_tail -= 1
    
    return energy, vad_flag


def fftq(NFFT, frams, quot_wn, quot):
    round_list = [[quot[0],quot[1],quot[2]]]
    for i in range(int(np.log2(NFFT))):
        round_list.append([quot[0],quot[1],quot[2]])
    my_q_fft = qFFT(NFFT, round_list, wq=quot_wn) 
    dtypeComplex = dtype_r2c(frams.dtype)
    stft_matrix = my_stft_nowindow(frams, n_fft=NFFT, dtype=dtypeComplex, fft_handle=my_q_fft.cal_fft)
    _, my_stages = my_q_fft.cal_fft_with_stage(frams.copy(), rfft=True)
    return stft_matrix, my_stages


def power(stft_matrix, quot):
    pow_rst = stft_matrix.real ** 2 + stft_matrix.imag ** 2
    return np.array(numfi(pow_rst, quot[0],quot[1],quot[2]))

def spectrum(mel_basis, mel_basis_q):
    melspec = np.dot(mel_basis, mel_basis_q)
    return melspec



def mel(pow_fft, quot):
    mel_filter_q = np.loadtxt('mel_filter.txt')
    mel_filter_q = (mel_filter_q/256).astype(np.float64)

    spec_q = spectrum(mel_filter_q, pow_fft)
    spec_q = np.array(numfi(spec_q, quot[0],quot[1],quot[2]))
    return spec_q


def log(spec_q, qinput, qcoeff, quot, need_save = False):
    cordic_ln = FixedCordic(qinput=qinput, qoutput=quot, qcoeff=qcoeff, iter_index=[-4,-3,-2,-1,0,1,2,3,4,5,6,7])
    lmfb = cordic_ln.ln(spec_q + 2**(-10)) * 0.4375  # 0.4375 = 112/256 = (128-16)/256 = (x>>1) - (x>>4)
    lmfb = np.array(numfi(lmfb,quot[0],quot[1],quot[2]))
    if need_save:  # no need when verification, only for design
        cordic_ln.save_e('../../../rom_data/cordicln_e.txt', 'hyperbolic')
    return lmfb

def quant(lmfb, input_scale, input_shift, input_zp, quot):
    mulscale = np.round(lmfb * np.array([input_scale])).astype(np.int64)
    addzp = (np.right_shift(mulscale, input_shift) + np.array([input_zp]))
    return mulscale, addzp & int((2**quot[1] - 1))

def fbank_main(pcm16k_int, json_path = "../../../hw_config.json", vad_en=False, vad_thre=10, vad_hang=0):
    config = load_json_config(json_path)
    PCMInList         = config["fbank_qat"]["PCMInList"]
    FFTList           = config["fbank_qat"]["FFTList"]
    FFTWinList        = config["fbank_qat"]["FFTWinList"]
    PowList           = config["fbank_qat"]["PowList"]
    MelList           = config["fbank_qat"]["MelList"]
    CordicCoefList    = config["fbank_qat"]["CordicCoefList"]
    CordicList        = config["fbank_qat"]["CordicList"]
    FbankList         = config["fbank_qat"]["FbankList"]

    NFFT              = 256
    SCALE             = config["NN_input_qat"]["scale"]
    ZEROPOINT         = config["NN_input_qat"]["zeropoint"]
    SHIFT             = config["NN_input_qat"]["shift"]

    ''' 16KHz PCM audio data, input may be 16bit signed Integer (1 signed bit, 15 frac bits) '''
    y = np.array(pcm16k_int)
    # y = np.random.randint(low=-2**15, high=2**15-1, size=[8000])
    y = y / 2**PCMInList[2]
    y = np.array(numfi(y, PCMInList[0], PCMInList[1], PCMInList[2]))

    ''' Low Pass Filter and downsample to 8KHz '''
    _,filter8K = lp_filter(y)
    filter8K = np.array(numfi(filter8K, PCMInList[0], PCMInList[1], PCMInList[2]))

    ''' Frame and Hanning Window '''
    frams = window(NFFT, NFFT, filter8K, quot=FFTList)
    print(frams.shape)

    ''' VAD '''
    if vad_en:
        energy, vad_flag = vad(frams*2**FFTList[2], threshold=vad_thre, hangover=vad_hang)
        vad_flag_index = np.array(np.where(vad_flag)).flatten()
        frams_after_vad = frams[:,vad_flag_index]
    else:
        vad_flag = np.ones(frams.shape[1])
        frams_after_vad = frams
    print(frams_after_vad.shape)

    ''' RFFT '''
    stft_matrix, fft_stages = fftq(NFFT, frams_after_vad, quot_wn=FFTWinList, quot=FFTList)
    print(stft_matrix.shape)

    ''' Power '''
    power_fft_q = power(stft_matrix, quot=PowList)
    print(power_fft_q.shape)

    ''' MEL '''
    spec_q = mel(power_fft_q, quot=MelList)
    print(spec_q.shape)  

    ''' Log '''
    lmfb = log(spec_q, qinput=MelList, qcoeff=CordicCoefList,quot=CordicList)
    print(lmfb.shape)  

    ''' Quant to uint8 '''
    _, lmfb_uint8 = quant(lmfb, SCALE, SHIFT, ZEROPOINT, quot=FbankList)
    print(lmfb_uint8.shape)

    return filter8K, frams, vad_flag, stft_matrix, fft_stages, power_fft_q, spec_q, lmfb, lmfb_uint8

if __name__ == '__main__':
    # window_param_gen(NFFT=256)
    # qfft_window_uint8 = np.loadtxt("win_rom.txt").astype(np.int32)
    # print(qfft_window_uint8.dtype)
    # print(qfft_window_uint8.shape)
    # print(qfft_window_uint8)
    # qfft_window = qfft_window_uint8 / 256

    # print(qfft_window.dtype)
    # print(qfft_window.shape)
    # print(qfft_window)

    # write_mel_data_to_file()
    
    pcm = np.random.randint(low=-2**15, high=2**15-1, size=[16000])
    filter8K, frams, vad_flag, stft_matrix, fft_stages, power_fft_q, spec_q, lmfb, lmfb_uint8 = \
            fbank_main(pcm16k_int=pcm*2**15, 
                          json_path = "../../../hw_config.json", 
                          vad_en=1, vad_thre=100, vad_hang=4)

    import matplotlib.pyplot as plt
    plt.figure()
    plt.imshow(lmfb_uint8)
    plt.show()