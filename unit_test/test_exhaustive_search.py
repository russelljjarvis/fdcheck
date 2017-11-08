###
# GA parameters
#MU = 12,
NGEN = 3
CXPB = 0.9
MU = 6; NGEN = 3; CXPB = 0.9
npoints = 2
nparams = 2

import ipyparallel as ipp
rc = ipp.Client(profile='default')
# create client & view
#rc = ipp.Client()
from ipyparallel import depend, require, dependent

dview = rc[:]

from neuronunit.optimization.nsga_object import NSGA
from neuronunit.optimization import exhaustive_search as es
###

NSGAO = NSGA()
NSGAO.setnparams(nparams=nparams)
invalid_dtc, pop, logbook, fitnesses = NSGAO.main(MU, NGEN)

import pickle
with open('complete_dump.p','wb') as handle:
   pickle.dump([invalid_dtc, pop, logbook, fitnesses],handle)
lists = pickle.load(open('complete_dump.p','rb'))


invalid_dtc, pop, logbook, fitnesses = lists[0],lists[1],lists[2]

dtcpopg = es.run_grid(npoints,nparams)
from find_min import min_find

# This function searches virtual model data containers to find the values with best scores.
minimagr,minimaga = min_find(invalid_dtc,dtcpopg)

# This function reports on the deltas brute force obtained versus the GA found attributes.
for k,v in minimagr.attrs.items():
    print(float(minimaga.attrs[k])-float(v),minimaga.attrs[k],v,k)


#print(scores_exh)
