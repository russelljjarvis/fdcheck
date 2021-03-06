
# coding: utf-8

# In[2]:

import os,sys
# Use local source for neuronunit
sys.path.insert(0,os.path.realpath('..'))


# In[2]:

#get_ipython().magic('matplotlib inline')
import numpy as np
import matplotlib
matplotlib.use('Agg')

import matplotlib.pyplot as plt
#plt.use('Agg')
import quantities as pq
from scipy.optimize import curve_fit
from neo.core import AnalogSignal
from neuronunit.tests import TimeConstantTest


import numpy as np
import neo
from elephant.spike_train_generation import threshold_detection
from quantities import mV, ms

import sciunit


# In[3]:

def make_snippet(total_time,amplitude,offset_time,tau):
    # Construct x and y without an exponential signal
    sampling_rate = 10000*pq.Hz # samples per ms
    total_samples = (total_time * sampling_rate).simplified
    assert total_samples.dimensionality == pq.dimensionless
    total_samples = int(total_samples)
    noise_sigma = 0.3*pq.mV
    times = np.linspace(0,float(total_time),total_samples)*pq.ms
    vm = AnalogSignal(noise_sigma*np.random.randn(total_samples),
                     times=times,
                     sampling_rate=sampling_rate.rescale(1/pq.ms))
    print(times)
    # Add the exponential signal
    samples_until_offset = (offset_time * sampling_rate).simplified
    assert samples_until_offset.dimensionality == pq.dimensionless
    samples_until_offset = int(samples_until_offset)
    #pdb.set_trace()

    exponential = amplitude*np.exp(-(times[samples_until_offset:]-offset_time)/tau)
    #print(times)
    #print(exponential)

    #for i, j in enumerate(vm[samples_until_offset:]):
    #    vm[i]+= exponential[i]

    vm[samples_until_offset:] += exponential

    from elephant.spike_train_generation import threshold_detection
    threshold=0.0*mV
    width=10*ms
    spike_train = threshold_detection(vm,threshold=threshold)

    # Fix for 0-length spike train issue in elephant.
    try:
        len(spike_train)
    except TypeError:
        spike_train = neo.core.SpikeTrain([],t_start=spike_train.t_start,
                                             t_stop=spike_train.t_stop,
                                             units=spike_train.units)

    #import pdb;
    #pdb.set_trace()
    snippets = [ vm[int(t)-int(width/2):int(t)+int(width/2)] for t in spike_train ]
    #result = neo.core.AnalogSignal(np.array(snippets).T.squeeze(),
    #                               units=vm.units,
    #                               sampling_rate=vm.sampling_rate)

    return snippets


# In[4]:

total_time = 100*pq.ms
amplitude = -10*pq.mV
offset_time = 30*pq.ms
tau = 7*pq.ms

snippets = make_snippet(total_time,amplitude,offset_time,tau)
print(snippets)
plt.plot(vm.times.rescale('ms'),vm)
plt.xlabel(pq.ms.symbol)
plt.ylabel(pq.mV.symbol);
plt.savefig('tau_test.png')


# In[5]:

test = TimeConstantTest(observation={'mean':tau,'std':np.sqrt(tau)})
i = {'duration':total_time, 'delay':offset_time}
tau_estimated = test.get_tau(vm,i).round(3)
print("Estimated tau = %s; Actual tau = %s" % (tau_estimated,tau))


# In[6]:

assert 0.95 < tau_estimated/tau < 1.05
