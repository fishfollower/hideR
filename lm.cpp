#include <TMB.hpp>
template<class Type>
Type objective_function<Type>::operator() ()
{
  DATA_VECTOR(X);
  DATA_VECTOR(Y);
  PARAMETER(alpha);
  PARAMETER(beta);
  PARAMETER(logsigma);
  Type sigma = exp(logsigma);
  Type nll = -sum(dnorm(Y, alpha*X+beta, sigma, true));
  ADREPORT(sigma);
  return nll;
}
