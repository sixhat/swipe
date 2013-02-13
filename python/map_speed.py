__author__ = 'david'

import time

def compute(a):
    """
    Here will just compute the result and return it
    """
    a=a*2+1
    a=0.0+a-1
    a = a/2
    return a ** 2 + 1 + 0.6 ** a


def f1():
    """
    first try is to run a simple loop over things and append them to local varible and then return them
    """
    results = []
    for a in range(-1000, 10000000L):
        results.append(compute(a))
    return results


def f3():
    """
    We'll use a global variable now.
    """
    for a in range(-1000, 10000000L):
        res.append(compute(a))



start_time = time.time()
res=[]
res=f1()
print "f1", time.time() - start_time, sum(res)

start_time = time.time()
res=[]
res=map(compute, range(-1000, 10000000L))
print "f2", time.time() - start_time, sum(res)

start_time = time.time()
res=[]
f3()
print "f3", time.time() - start_time, sum(res)

start_time = time.time()
res=[]
res=[compute(x) for x in range(-1000,10000000L)]
print "f4", time.time() - start_time, sum(res)

start_time = time.time()
res=[]
from multiprocessing import Pool
_p = Pool()
res=_p.map(compute, range(-1000, 10000000L))
print "f5", time.time() - start_time, sum(res)

