
def min_find(invalid_dtc,dtcpopg):
    import numpy as np
    sovg=[]
    for i in invalid_dtc:
        rt = 0 # running total
        for values in i.scores.values():
            rt += np.sum(values)
        sovg.append(rt)

    minimaga = invalid_dtc[np.where(sovg==np.min(sovg))[0][0]]

    sova=[]
    for i in dtcpopg:
        rt = 0 # running total
        for values in i.scores.values():
            rt += np.sum(values)
        sova.append(rt)

    minimagr = dtcpopg[np.where(np.min(sova)==sova)[0][0]]
    return minimaga, minimagr
