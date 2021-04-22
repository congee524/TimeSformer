modes = ['train', 'val']

def convert_anno(mode):
    ori_fname = 'kinetics400_{}_list_rawframes.txt'.format(mode)
    tar_fname = '{}.csv'.format(mode)
    res_lines = []
    with open(ori_fname, 'r') as f:
        lines = f.readlines()
        for line in lines:
            label, total_frames, class_id = line.split(' ')
            res_lines.append(label + ',' + class_id)
    
    with open(tar_fname, 'w') as f:
        for res in res_lines:
            f.write(res)

for mode in modes:
    convert_anno(mode)
