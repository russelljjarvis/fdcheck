###
# GA parameters:
##
NGEN = 3
MU = 6; NGEN = 3; CXPB = 0.9
# about 18, models will be made, excluding rheobase search.

##
# Grid search parameters:
##
npoints = 3
nparams = 3



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
from find_min import min_find
# This function searches virtual model data containers to find the values with best scores.
minimaga,minimagr = min_find(invalid_dtc,dtcpopg)
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
exit()
#quit()





#print(scores_exh)
