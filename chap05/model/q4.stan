data {
  int I;
  int<lower=0, upper=1> A[I];
  real<lower=0, upper=1> Score[I];
  real<lower=1, upper=3> WID[I];// 天気を1-3で表す
  int<lower=0, upper=1> Y[I];
}

parameters {
  // 配列にしている
  real b[3];
  real bw2;// b for cloudy
  real bw3;// b for rainy
}

transformed parameters {
  real bw[3];
  real q[I];
  
  bw[1] = 0;
  bw[2] = bw2;
  bw[3] = bw3;
  
  for (i in 1:I)
    q[i] = inv_logit(b[1] + b[2]*A[i] + b[3]*Score[i] + bw[WID[i]] );

}

model {
  for (i in 1:I)
    Y[i] ~ bernoulli(q[i]);
}
