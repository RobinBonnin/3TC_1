#include <iostream>
#include "BigInt.h" 

using namespace std; 

/**
 * Function that computes the factorial of a given integer 
 * @param n any strictly positive integer 
 * @tparam any integer type
 */
template <typename I>
I factorial(const I& n) 
{
  I res = 1; 
  for (I i = 2; i <= n; i += 1)
    {
      res *= i; 
    }
  return res;  
}

//----------------------------------------------------------
int main( int argc, char** argv )
{

  typedef int Integer; //type of integer used below

  Integer n = (argc > 1) ? std::atoi(argv[1]) : 20; 
  for (Integer i = 1; i <= n; i += 1)
    {
      std::cout << i << "! == " << factorial(i) << std::endl; 
    }

  return 0; 
}
