#include "BigInt.h"

//////////////////////////////////////////////////////////////////////////////
// IMPLEMENTATION of methods.
///////////////////////////////////////////////////////////////////////////////

const BigInt::Digit BigInt::base = 10; 

// ----------------------- Standard services -----------------------------------
//------------------------------------------------------------------------------
BigInt::BigInt(): myVector()
{
}

//------------------------------------------------------------------------------
BigInt::BigInt(const int& aInt): myVector()
{
  int reste = aInt;
  while (reste != 0)
  {
    myVector.push_back( static_cast<Digit>(reste % base) );
    reste /= base;
  }
}

//------------------------------------------------------------------------------
BigInt::BigInt(const std::string& aStrInt): myVector()
{
  if(aStrInt[0] != '0' ){
    for(int i = aStrInt.length(); i > 0; i--) {
      int number = aStrInt[i] -'0';
      myVector.push_back(number);
    }
  }

}
//------------------------------------------------------------------------------
BigInt::BigInt(const BigInt& other): myVector(other.myVector)
{
}

//------------------------------------------------------------------------------
  BigInt&
BigInt::operator=(const BigInt& other)
{
  if (this != &other)
  {
    myVector = other.myVector; 
  }
  return *this; 
}

//------------------------------------------------------------------------------
BigInt::~BigInt()
{
}

//------------------------------------------------------------------------------
bool BigInt::isValid() const
{
  if (myVector.size() != 0)
    return (myVector.back() != 0);
  else
    return true; 
}

// ----------------------- Comparison operators --------------------------------
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
bool
BigInt::operator==(const BigInt& other) const
{
  if(myVector.size() == other.myVector.size()) {
    if(std::equal(myVector.begin(), myVector.end(), other.myVector.begin())) {
      return true;
    }
    else{
      return false;
    }
  }
  else{
    std::cout << "Les 2 vecteurs n'ont pas la même taille" << std::endl;
    return false;
  }
}

//------------------------------------------------------------------------------
bool
BigInt::operator!=(const BigInt& other) const
{
  if(myVector.size() == other.myVector.size()) {
    if(std::equal(myVector.begin(), myVector.end(), other.myVector.begin())) {
      return false;
    }
    else{
      return true;
    }
  }
  else{
    return true;
  }
}


// ----------------------- Arithmetical operators ------------------------------
//------------------------------------------------------------------------------
BigInt
BigInt::operator+(const BigInt& other) const
{
  BigInt res = *this; 
  res += other; 
  return res; 
}
//------------------------------------------------------------------------------
  BigInt&
BigInt::operator+=(const BigInt& other)
{
  int ret=0;
  int max = std::max(other.myVector.size(), myVector.size());
  int min = std::min(other.myVector.size(), myVector.size());
  
  for( int j = 0; j < min; j++ ) {
    int m = myVector[j] + other.myVector[j] + ret;
    int res = m%10;
    ret = m/10;
    myVector[j] = res;
  }

  if(other.myVector.size() > myVector.size()) {		  
    for (int j = min; j < max; j++) {
      int x = other.myVector[j] + ret;
      int res = x%10;
      ret = x/10;
      myVector.push_back(res);
    }
    if(ret !=0) {
      myVector.push_back(ret);
    }
  }
  else {
    for(int j = min; j < max; j++){
      int res = (myVector[j] + ret)%10;
      ret = (myVector[j] + ret)/10;
      myVector[j] = res;
    }
    if(ret !=0){
      myVector.push_back(ret);
    }
  }
  return *this;
}
//------------------------------------------------------------------------------
BigInt
BigInt::operator*(const BigInt& other) const
{
  BigInt sum, partial; //NB: initialized to zero by default

  //TODO

  //1) buffer step

  //2) for each digit
  //multiplication by a digit
  //mutliplication by a power of base
  //sum

  return sum; 
}

//------------------------------------------------------------------------------
  BigInt&
BigInt::operator*=(const BigInt& other)
{
  *this = operator*(other); //assignment 
  return *this; 
}

///////////////////////////////////////////////////////////////////////////////
// Hidden services

///////////////////////////////////////////////////////////////////////////////
// Streams
/**
 * Writes/Displays the object on an output stream.
 * @param out the output stream where the object is written.
 */

void
BigInt::selfDisplay ( std::ostream & out ) const
{
  if (myVector.size() == 0)
    out << "0";
  else
    std::copy( myVector.rbegin(), myVector.rend(), std::ostream_iterator<Digit>(out, "" ) ); 
}


///////////////////////////////////////////////////////////////////////////////
// Implementation of functions                                               //
  std::ostream&
operator<< ( std::ostream & out, 
    const BigInt& object )
{
  object.selfDisplay( out );
  return out;
}
