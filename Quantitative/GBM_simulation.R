
  library(data.table)


GBM <- function(S0, mu, sigma, horizon_yrs, n_simul, days_p_yr){
  set.seed(4321)
  t <- seq(0, horizon_yrs, 1/days_p_yr)
  St_vec <- matrix(S0, horizon_yrs*days_p_yr+1, n_simul)
  Z1<-matrix(rnorm(horizon_yrs*days_p_yr*n_simul, 0, 1),horizon_yrs*days_p_yr)
  
  for(i in 1:n_simul){
    for(j in 1:(horizon_yrs*days_p_yr)){
      St_vec[j+1, i] <- St_vec[j,i] * exp((mu-1/2*sigma^2)*(t[j+1]-t[j]) + sigma * sqrt(t[j+1]-t[j]) * Z1[j,i])
    }
  }
  return(St_vec)
}

horizon_yrs<-10

price_0<-1.2

days_p_yr<-250

n_simul<-1000

ann_growth<-0.01

ann_vol<-0.1

S0<-rep(price_0,days_p_yr,n_simul)

mu<-ann_growth

sigma<-ann_vol

random_paths<-as.data.frame(GBM(S0,mu,sigma,horizon_yrs,n_simul,days_p_yr))
setDT(random_paths)


#Check
mean(as.numeric(random_paths[251,]))/mean(as.numeric(random_paths[1,]))




