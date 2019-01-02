#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import xlrd
import random
import shutil
import os



def jxme(filepath, tjfile):
    workbook = xlrd.open_workbook(tjfile)
    name_list = workbook.sheet_by_index(0).col_values(4)[2:]
    file_list = os.listdir(filepath)

    # 随机选取已存在文件进行复制，使人名数和文件数对应。
    if len(name_list) > len(file_list):
        for i in range(len(name_list) - len(file_list)):
            n = random.randint(0, len(file_list) - 1)
            src_file = os.path.join(filepath, file_list[n])
            nfn1 = re.match(r'(\w+-)(\w+).xlsx', file_list[n]).group(1)
            new_file = os.path.join(filepath, nfn1 + str(i) + '.xlsx')
            shutil.copyfile(src_file, new_file)
            print('Create newfile = %s, srcfile = %s OK!' % (new_file, src_file))
        file_list = os.listdir(filepath)
    elif len(name_list) < len(file_list):
        file_list = file_list[:len(name_list)]
    else:
        pass

    # 打乱生成的人名和文件名顺序。
    random.shuffle(name_list)
    random.shuffle(file_list)
    for n, f in zip(name_list, file_list):
        src_name = re.match(r'(\w+-)(\w+).xlsx', f).group(1)
        src_file = os.path.join(filepath, f)
        new_file = os.path.join(filepath, src_name + n + '.xlsx')
        os.rename(src_file, new_file)
        print('Rename src_file = %s, new_file = %s' % (src_file, new_file))

    zip_file_name = os.path.join(os.path.split(filepath)[0] + '考核')

    # 判断上级目录是否存在同名文件。
    while os.path.isfile(zip_file_name + '.zip'):
        p, n = os.path.split(zip_file_name)
        n = str(random.randint(0, 1000)) + '_' + n
        zip_file_name = os.path.join(p, n)

    shutil.make_archive(zip_file_name, 'zip', filepath)
    print('Create zip file = %s' % zip_file_name)



if __name__ == '__main__':
    jxme(r'E:\考核', r'E:\1月绩效考核人员名单.xlsx')