t<-0
I<-0
U<-runif(1,0,1)
lam<-1
t<- -log(U)/lam
S<-c()
while(t<100){
  I<-I+1
  S<-c(S,t)
  U<-runif(1,0,1)
  t<-t-log(U)/lam
}

plot(S,type = 'l')

plot(S,1:length(S),type='s')
