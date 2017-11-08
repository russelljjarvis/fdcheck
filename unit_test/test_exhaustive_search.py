###
# GA parameters:
##
NGEN = 2
MU = 4; NGEN = 3; CXPB = 0.9
# about 12, models will be made, excluding rheobase search.

##
# Grid search parameters:
##
npoints = 5
nparams = 1



import ipyparallel as ipp
rc = ipp.Client(profile='default')
from ipyparallel import depend, require, dependent
dview = rc[:]

from neuronunit.optimization.nsga_object import NSGA
from neuronunit.optimization import exhaustive_search as es
###
NSGAO = NSGA()
NSGAO.setnparams(nparams=nparams)
invalid_dtc, pop, logbook, fitnesses = NSGAO.main(MU, NGEN)
'''
uncomment to facilitate checkpointing.
import pickle
with open('complete_dump.p','wb') as handle:
   pickle.dump([invalid_dtc, pop, logbook, fitnesses],handle)
lists = pickle.load(open('complete_dump.p','rb'))
invalid_dtc, pop, logbook, fitnesses = lists[0],lists[1],lists[2], lists[3]
'''
dtcpopg = es.run_grid(npoints,nparams)

# This function searches virtual model data containers to find the values with best scores.
def min_find(dtcpop):
    import numpy as np
    sovg=[]
    for i in dtcpop:
        rt = 0 # running total
        for values in i.scores.values():
            rt += sqrt(mean(square(list(values)))
        sovg.append(rt)
    dtc = invalid_dtc[np.where(sovg==np.min(sovg))[0][0]]
    return dtc

def min_max(dtcpop):
    import numpy as np
    sovg=[]
    for i in dtcpop:
        rt = 0 # running total
        for values in i.scores.values():
            rt += sqrt(mean(square(list(values)))
        sovg.append(rt)
    dtc = invalid_dtc[np.where(sovg==np.max(sovg))[0][0]]
    return dtc

minimaga = min_find(invalid_dtc)
minimagr = min_find(dtcpopg)
maximagr = min_max(dtcpopg)
# quantize distance between minimimum error and maximum error.
quantize_distance = list(np.linspace(minimagr,maximagr,10))
assert minimaga < quantize_distance[1]



print('Report: ')
# This function reports on the deltas brute force obtained versus the GA found attributes.
for k,v in minimagr.attrs.items():
    print('the difference between brute force candidates model parameters and the GA\'s model parameters:')
    print(float(minimaga.attrs[k])-float(v),minimaga.attrs[k],v,k)
print('the difference between the bf error and the GA\'s error:')
print('grid search:')
from numpy import square, mean, sqrt
rmsg=sqrt(mean(square(list(minimagr.scores.values()))))
print(rmsg)
print('ga:')
rmsga=sqrt(mean(square(list(minimaga.scores.values()))))
print(rmsga)
print('maximum error:', maximagr)

# Two things to find:
# How close togethor are the model parameters in parameter space (hyper volume), relative to the dimensions of the HV?
# ie get the euclidian distance between the two sets of model parameters.

#
#
#

exit()
#quit()





#print(scores_exh)
