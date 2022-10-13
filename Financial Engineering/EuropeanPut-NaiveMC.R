# Closed form plain vanilla Euroean Option
d1<- (log(S0/K)+(r+sigma^2/2)*Tcap)/(sigma* sqrt(Tcap))
d2<- d1-sigma*sqrt(Tcap)

C_clos<-S0*pnorm(d1)-exp(-r*Tcap)*K*pnorm(d2)

# Naive Monte Carlo - European
C<-rep(NA,n)
for(i in 1:n){
  C[i]<-exp(-r*Tcap)*max((S0*exp((r-sigma^2/2)*Tcap+sigma*sqrt(Tcap)*rnorm(1,0,1))-K),0)
}
mean(C)
C_clos