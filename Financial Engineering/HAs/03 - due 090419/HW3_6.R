# Barrier Option Naive Monte Carlo
Euler.Barrier.MC<-function(S0=60,K=50,b=40,r=0.01,sigma=0.4,Tcap=1/4,m=65,n=10000){
#65 is the num. of days in the current quarter
# iterations for naive monte carlo - plain vanilla
Ps<-rep(NA,n)
S<-as.data.frame(matrix(rep(c(S0,rep(NA,m)),n),ncol=n))
names(S)<-paste0('Path.',c(1:n))
exting<-0 # records the number of knock-outs
for(i in 1:n){
  for(j in 1:(m)){
  S[j+1,i]<-S[j,i]*exp((r-sigma^2/2)*Tcap/m+sigma*sqrt(Tcap/m)*rnorm(1,0,1))
  }
  I_S<-1*(min(S[,i])>b*exp(-0.5826*sigma*sqrt(Tcap/m)))
  exting<-exting+(1-I_S)
  Ps[i]<-exp(-r*Tcap)*(I_S*max(K-S[m+1,i],0))
}
S<-cbind(c(0:m),S)
names(S)[1]<-'Day'
P_est<-mean(Ps)
return(list(P_do=P_est,MC_SE=(sqrt(sum((Ps-P_est)^2)/(n-1)))/sqrt(n),Knock.Outs=exting,Paths.Frame=S))
}

tic()
n<-10000
Put<-Euler.Barrier.MC()
toc()

Put$P_do
Put$MC_SE

# Repeat with only 200 paths for a plot
Put.200<-Euler.Barrier.MC(n = 200)
s.pl<-gather(Put.200$Paths.Frame,'Path','Stock_Price',2:201)
ggplot(s.pl,aes(Day,Stock_Price,group=Path))+
geom_rect(aes(xmin=0, xmax=65, ymin=40,ymax=50,group=Path),color="transparent", fill="cadetblue1", alpha=0.003)+
geom_rect(aes(xmin=0, xmax=65, ymin=30,ymax=40,group=Path),color="transparent", fill="orange", alpha=0.01)+
geom_line(aes(colour=Path))+
#geom_text(c('Option in the money','KO'),mapping = aes(x=c(1,1),y=c(42,32)))+
theme(legend.title = element_blank())+
theme(legend.position = "none")+
ggtitle('Stock paths')+
annotate(geom="text", x=7, y=45, label="Option in the money",color="darkslategray4")+
annotate(geom="text", x=2, y=35, label="K.O.",color="darkorange3")


