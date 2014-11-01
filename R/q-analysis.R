# Copyright (c) 2014, David Sousa-Rodrigues
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


## ----q-analysis funtions-------------------------------------------------

plot_qanalysis<-function(q,svm){
  upm<-svm
  upm[svm>q]<-1
  upm[svm<=q]<-0
  upm
  
  g = graph.adjacency(upm, mode='undirected')
  gi = induced.subgraph(g, V(g)[degree(g)>0])
  gi.cl<-clusters(gi)
  
  for (k in 1:gi.cl$no){
    print(V(gi)[gi.cl$membership==k])
  }
  print("")
  print(paste("Number of Connected Components", gi.cl$no))
  print(gi.cl$csize)
  
  gi.cl$no
  gi<-simplify(gi)
  plot(gi)
  gi
}

get_level<-function(q, svm){
  a <- ""
  # Calculate adjacency matrix for dimension q or higher 
  upm<-svm
  upm[svm>q]<-1
  upm[svm<=q]<-0
  upm
  
  g = graph.adjacency(upm, mode='undirected')
  gi = induced.subgraph(g, V(g)[degree(g)>0])
  gi.cl<-clusters(gi)
  
  for (k in 1:gi.cl$no){
    mm  <- V(gi)[gi.cl$membership==k]
    a  <- paste(a, "--- component:\n")
    for (b in mm){
      a  <- paste(a,V(gi)[b]$name)    
    }
    a  <- paste(a, "\n")    
  }
  a  <- paste(a, "--- Number of Connected Components:", gi.cl$no, "\n")
  a  <- paste(a, "--- Size of Components:")
  for (b in gi.cl$csize){
    a  <- paste(a, b)  
  }
  return(list(connected=gi.cl$no, maxsize=max(gi.cl$csize), text=a))
}

qanalysis<-function(svm){
  require(igraph)
  maxq <- max(svm)-1
  connected <- rep(0,maxq)
  maxsize <- rep(0,maxq)
  ant  <- ""
  for (q in 1:maxq){
    lev <- get_level(q, svm) 
    if (!identical(lev$text, ant)){
      writeLines(paste("==========================================================================================\nq-level", q, "\n", lev$text))  
      ant = lev$text
    }
    connected[q]<-lev$connected
    maxsize[q] <- lev$maxsize
  }
  writeLines(paste("==========================================================================================\nq-level", maxq, "\n", lev$text))  
  return(list(q=connected, m=maxsize))
}




