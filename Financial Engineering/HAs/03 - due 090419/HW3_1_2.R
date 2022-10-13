set.seed(2019)

paths.VAS<-function(r0=0.02,r=0.05,gamma=0.2,sigma=0.015,steps=250,n.paths=40){
  Tcap<-1
  h<-Tcap/steps
  r_t<-as.data.frame(matrix(rep(c(r0,rep(NA,steps-1)),n.paths),ncol = n.paths))
  names(r_t)<-paste0(rep('Path.',n.paths),c(1:n.paths))    
    for(j in 1:n.paths){
      for(i in 2:250){r_t[i,j]<-r_t[i-1,j]*exp(-gamma*h)+r*(1-exp(-gamma*h))+sigma*sqrt((1-exp(-2*gamma*h))/(2*gamma))*rnorm(1,0,1)}
    }
  A<-cbind(c(1:steps),r_t)
  names(A)[1]<-'Step'
  return(A)
}

pl.dt.vas<-gather(paths.VAS(),'Path','Value',2:41)
pl.dt.vas5<-gather(paths.VAS(gamma=5),'Path','Value',2:41)

ggplot(pl.dt.vas,aes(Step,Value,group=Path))+
  geom_line(aes(colour=Path))+
  theme(legend.title = element_blank())+
  theme(legend.position = "none")+
  ggtitle('Vasicek paths - gamma=0.2')

ggplot(pl.dt.vas5,aes(Step,Value,group=Path))+
  geom_line(aes(colour=Path))+
  theme(legend.title = element_blank())+
  theme(legend.position = "none")+
  ggtitle('Vasicek paths - gamma=5')



paths.CIR<-function(r0=0.02,r=0.05,gamma=1.2,alpha=0.04,steps=250,n.paths=40,negs='truncate'){
Tcap<-1
h<-Tcap/steps
r_t<-as.data.frame(matrix(rep(c(r0,rep(NA,steps-1)),n.paths),ncol = n.paths))
names(r_t)<-paste0(rep('Path.',n.paths),c(1:n.paths))    
  if(negs=='truncate'){
      for(j in 1:n.paths){
        for(i in 2:250){r_t[i,j]<-gamma*r*h+(1-gamma*h)*max(r_t[i-1,j],0)+sqrt(alpha*max(r_t[i-1,j],0)*h)*rnorm(1,0,1)}
      }
  }else if(negs=='reflect'){
      for(j in 1:n.paths){
        for(i in 2:250){r_t[i,j]<-gamma*r*h+(1-gamma*h)*max(r_t[i-1,j],-r_t[i-1,j])+sqrt(alpha*max(r_t[i-1,j],-r_t[i-1,j])*h)*rnorm(1,0,1)}
      }
  }else{stop("Only two options for handling negative r values are 'truncate' and 'reflect'" )}
      
A<-cbind(c(1:steps),r_t)
names(A)[1]<-'Step'
return(A)
}

pl.dt<-gather(paths.CIR(),'Path','Value',2:41)
pl.dt.refl<-gather(paths.CIR(negs = 'reflect'),'Path','Value',2:41)

ggplot(pl.dt,aes(Step,Value,group=Path))+
geom_line(aes(colour=Path))+
theme(legend.title = element_blank())+
theme(legend.position = "none")+
ggtitle('CIR paths - truncated to zero in case of r<0')

ggplot(pl.dt.refl,aes(Step,Value,group=Path))+
  geom_line(aes(colour=Path))+
  theme(legend.title = element_blank())+
  theme(legend.position = "none")+
  ggtitle('CIR paths - reflected around zero in case of r<0') 