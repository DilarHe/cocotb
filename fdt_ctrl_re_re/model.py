import os
import csv
import pandas as pd 
from tqdm import tqdm
import numpy
from matplotlib import pyplot as plt

modeDict = {1:'DOWN-UP',2:'HEAVY-LIGHT'}


def get_model_set(param_file):
    param_set,version = 0,0
    if '/' in param_file:
        param_set = param_file.split('/')[-1].split('_')[1]
        print(param_set)
    input_num = int(param_set.split('-')[0])
    output_num = int(param_set.split('-')[1])
    # output_num = int(param_set.split('-')[1])

def RunDemo(param_file,data_root,cali_base,cali_touch,mode):
    print('=============== mode {}'.format(modeDict[mode]))
    get_model_set(param_file)
    
    
if __name__ == '__main__':
    data_root = r'/home/zyy/coco_work/cocoTest/fdt_ctrl_re_re/raw_data'
    mode = 1 # fdt mode , 1 dwup 2 hevlit
    
    param_file = r'/home/zyy/coco_work/cocoTest/fdt_ctrl_re_re/raw_data' \
                 r'/RNN-MODE1-Topsamp-2N-Norm_64-3-16-2.csv'
    cali_base,cali_touch = 0,0
    print(param_file)
    RunDemo(param_file,data_root,cali_base,cali_touch,mode)