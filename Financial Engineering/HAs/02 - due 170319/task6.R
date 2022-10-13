library(tictoc)
#rm(list = ls())
tic()
n<-50000
reps<-10000

prob20<-rep(NA,reps)

for(i in 1:reps){
set.seed(i)
X<- rexp(n = n,1)
prob20[i]<- sum(X>20)/n
}

Theta_n<-mean(prob20)

v_naive<-sum((prob20-Theta_n)^2)/(reps-1)
toc()







trials<-1/seq(2,30,2)
vs<-rep(NA,length(trials))



X_g<-rexp(n,lamb_g)
Theta_IS<-sum(sapply(X_g,h)*f(X_g)/g(X_g))/n


for(k in trials){
tic()
l<-l+1

n<-50000
reps<-10000
lamb_g<-1/20

h<-function(x){
  if(x >=20){a<-1}else{a<-0}
  return(a)
}

f<-function(x){
  return(exp(-x))
}

g<-function(x){
  return(lamb_g*exp(-lamb_g*x))
}

prob20_IS<-rep(NA,reps)

for(i in 1:reps){
  set.seed(i)
  X_g<-rexp(n,lamb_g)
  prob20_IS[i]<-sum(sapply(X_g,h)*f(X_g)/g(X_g))/n
    
}

Theta_IS_n<-mean(prob20_IS)
v_IS<-sum((prob20_IS-Theta_IS_n)^2)/(reps-1)
vs[l]<-v_IS


}




vs
plot(1/seq(2,30,2)[4:length(vs)],vs[4:length(vs)])  



plot(seq(0,8,1/1000),dexp(seq(0,8,1/1000),1),type = 'l',ylim = c(0,0.2))
lines(seq(0,8,1/1000),dexp(seq(0,8,1/1000),1/20))







ns<-c(500,1000,5000,10000,50000)
vs<-rep(NA,5)

for(j in 1:5){
  tic()
n<-ns[j]
reps<-10000
lamb_g<-1/20
prob20_IS<-rep(NA,reps)
prob20_IS2<-rep(NA,reps)

h<-function(x){
  if(x >=20){a<-1}else{a<-0}
  return(a)
}

f<-function(x){
  return(exp(-x))
}

g<-function(x){
  return(lamb_g*exp(-lamb_g*x))
}

for(i in 1:reps){
  set.seed(i)
  X_g<-rexp(n,lamb_g)
  prob20_IS[i]<-sum(sapply(X_g,h)*f(X_g)/g(X_g))/n
}

Theta_IS_n<-mean(prob20_IS)
v_IS<-sum((prob20_IS-Theta_IS_n)^2)/(reps-1)
vs[j]<-v_IS

print(rbind(c('Theta_IS','VAR_IS'),c(Theta_IS_n,v_IS)))
toc()
}
