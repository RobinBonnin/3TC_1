#include <iostream>
#include "BigInt.h" 

using namespace std; 

/**
 * Test default-construction, copy, assignment, equality, stream. 
 * @param i any integer
 * @tparam any integer type
 */
template <typename I>
bool testBasicServices(const I& i) {

  cout << " basic services: (" << i << ")" << endl; //stream

  I i1(i); //copy constructor
  I i2; //default constructor
  i2 = i; //assignment

  //equality, validity
  return ( (i2 == i1)&&(i1 == i)&&
	   (!(i2 != i1))&&(!(i1 != i))&&
	   (i.isValid())&&(i1.isValid())&&(i2.isValid()) ); 
}

/**
 * Test for the addition between two integers 
 * @param i any integer
 * @param j any integer
 * @tparam any integer type
 */
template <typename I>
bool testAdd(const I& i, const I& j, const I& res) 
{
  cout << "(" << i << " + " << j << ")" << endl;
  return ( ( (i + j) == res ) && ( (j + i) == res) ); 
}

/**
 * Test for the product between two integers 
 * @param i any integer
 * @param j any integer
 * @tparam any integer type
 */
template <typename I>
bool testMul(const I& i, const I& j, const I& res) 
{
  cout << "(" << i << " * " << j << ")" << endl;
  return ( ( (i * j) == res ) && ( (j * i) == res) ); 
}

//----------------------------------------------------------
int main( int argc, char** argv )
{

  bool res = testBasicServices( BigInt(321) ) 
    && testAdd( BigInt(1), BigInt(2), BigInt(3) ) 
    && testAdd( BigInt(1), BigInt(112), BigInt(113) ) 
    && testAdd( BigInt(111), BigInt(2), BigInt(113) ) 
    && testAdd( BigInt(8), BigInt(2), BigInt(10) ) 
    && testAdd( BigInt(9), BigInt(9), BigInt(18) ) 
    && testAdd( BigInt(1), BigInt(99), BigInt(100) ) 
    && testAdd( BigInt("11111111111111111111"), BigInt("22222222222222222222"), BigInt("33333333333333333333") ) 
    && testAdd( BigInt("176547145433768176381"), 
		BigInt("1879381793871987391873981793816635716543651465346"), 
		BigInt("1879381793871987391873981793993182861977419641727") ) 
    && testAdd( BigInt("999999999899999999999999"), BigInt("1"), BigInt("999999999900000000000000") ) 
    && testMul( BigInt(1), BigInt(2), BigInt(2) ) 
    && testMul( BigInt(9), BigInt(9), BigInt(81) ) 
    && testMul( BigInt("11111111111111111111"), BigInt("22222222222222222222"), BigInt("246913580246913580241975308641975308642") ) 
    && testMul( BigInt("176547145433768176381"), 
		BigInt("1879381793871987391873981793816635716543651465346"), 
		BigInt("331799490888293882962852097413707190125848150747633665675992837192826") ) 
    ; 

  cerr << ( res ? "Passed." : "Error." ) << endl;
  return res ? 0 : 1;
}
