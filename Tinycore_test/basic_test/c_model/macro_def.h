
#define KWS_MAX_VAL 255
#define KWS_MIN_VAL 0

#define FBANK_CHANNEL 32
#define FBANK_WIDTH   60

#define kws_max(a, b)           \
    ({                          \
        __typeof__(a) _a = (a); \
        __typeof__(b) _b = (b); \
        _a > _b ? _a : _b;      \
    })

#define kws_min(a, b)           \
    ({                          \
        __typeof__(a) _a = (a); \
        __typeof__(b) _b = (b); \
        _a < _b ? _a : _b;      \
    })

