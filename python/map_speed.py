__author__ = "david"
from typing import List, Iterable
from multiprocessing import Pool
import time


def compute(a: float) -> float:
    """
    Here will just compute the result and return it
    """
    a = a * 2 + 1
    a = 0.0 + a - 1
    a = a / 2
    return a ** 2 + 1 + 0.6 ** a


def f1():
    """
    first try is to run a simple loop over things and append them to local varible and then return them
    """
    results = []
    for a in range(-1000, 10000000):
        results.append(compute(a))
    return results


def f3():
    """
    We'll use a global variable now.
    """
    for a in range(-1000, 10000000):
        res3.append(compute(a))


start_time = time.time()
res: List[float] = []
res = f1()
print("f1", time.time() - start_time, sum(res))

start_time = time.time()
res2: Iterable[float] = []
res2 = map(compute, range(-1000, 10000000))
print("f2", time.time() - start_time, sum(res))

start_time = time.time()
res3: List[float] = []
f3()
print("f3", time.time() - start_time, sum(res))

start_time = time.time()
res4: List[float] = []
res4 = [compute(x) for x in range(-1000, 10000000)]
print("f4", time.time() - start_time, sum(res))

start_time = time.time()
res5: Iterable[float] = []
_p = Pool()
res5 = _p.map(compute, range(-1000, 10000000))
print("f5", time.time() - start_time, sum(res))
