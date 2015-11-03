/**
 * @file BigInt.h
 * Header file for module BigInt.cpp
 */

#if defined(BigInt_RECURSES)
#error Recursive header files inclusion detected in BigInt.h
#else // defined(BigInt_RECURSES)
/** Prevents recursive inclusion of headers. */
#define BigInt_RECURSES

#if !defined BigInt_h
/** Prevents repeated inclusion of headers. */
#define BigInt_h

//////////////////////////////////////////////////////////////////////////////
// Inclusions
#include <cstdlib>
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <iterator>
#include <functional>
//////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
// class BigInt
/**
 * \brief Aim: implements a positive non bounded integer as an array of digits.
 */
class BigInt
{
public: 
  // ------------------------- Inner types ----------------------------------

  /// integral type for the digits
  typedef int Digit;
  /// type for the array of digits
  typedef std::vector<Digit> Container; 
  /// type for the number of digits
  typedef Container::size_type Size; 

  // ------------------------- static constants ------------------------------
  ///base of the number (10)
  static const Digit base;  

  // ------------------------- Private Datas --------------------------------
private:
  ///dynamic array of digits 
  Container myVector; 

public:    
  // ----------------------- Standard services ------------------------------

  /** 
   * Create a big integer initialized to zero.
   */
  BigInt();

  /** 
   * Create a big integer from an int.
   */
  BigInt(const int& aInt);

  /** 
   * Create a big integer from a string.
   */
  BigInt(const std::string& aStrInt);

  /**
   * Copy constructor.
   * @param other the object to clone.
   */
  BigInt(const BigInt & other);

  /** 
   * Assignment operator
   * @param other the big integer to copy.
   * 
   * @return reference on the big integer
   */
  BigInt& operator=(const BigInt& other);

  /**
   * Destructor.
   */
  ~BigInt();

  /**
   * Check if this object is valid
   * @return 'true' if valid, ie.
   * the number contains no digit (== 0)
   * or the leftmost digit is not zero. 
   * 'false' otherwise
   */
  bool isValid() const;


  // ----------------------- Comparisons operators ------------------------------
  /** 
   * Equality
   * @param other the big integer to compare with.
   * @return 'true' it the two integers are equal, 
   * 'false' otherwise
   */
  bool operator==(const BigInt& other) const;

  /** 
   * Difference
   * @param other the big integer to compare with.
   * @return 'true' it the two integers are equal, 
   * 'false' otherwise
   * @see operator==
   */
  bool operator!=(const BigInt& other) const;

  // ----------------------- Arithmetic operators ------------------------------
  /** 
   * Addition between this integer and @a aBigInt.
   * @param aBigInt the big integer to add to.
   * @return the summed big integer
   * @see operator+
   */
  BigInt  operator+(const BigInt & aBigInt) const;

  /** 
   * Addition and assignment between this integer 'this' and @a aBigInt.
   * @param aBigInt the big integer to add to.
   * @return a reference to the result
   */
  BigInt & operator+=(const BigInt & aBigInt);

  /** 
   * Product between this integer and @a aBigInt
   * @param aBigInt the big integer to multiply with
   * @return the resulting big integer
   */
  BigInt  operator*(const BigInt & aBigInt) const;
 
  /** 
   * Product and assignment between this integer and @a aBigInt
   * @param aBigInt the big integer to multiply with
   * @return a reference to the result
   */
  BigInt & operator*=(const BigInt & aBigInt);
 
  // ----------------------- Stream --------------------------------------
public:

  /**
   * Writes/Displays the object on an output stream.
   * @param out the output stream where the object is written.
   */
  void selfDisplay ( std::ostream & out ) const;
    

  // ------------------------- Hidden services ------------------------------
private:

}; // end of class BigInt

/**
 * Overloads 'operator<<' for displaying objects of class 'BigInt'.
 * @param out the output stream where the object is written.
 * @param object the object of class 'BigInt' to write.
 * @return the output stream after the writing.
 */
std::ostream&
operator<< ( std::ostream & out, const BigInt& object );


//                                                                           //
///////////////////////////////////////////////////////////////////////////////

#endif // !defined BigInt_h

#undef BigInt_RECURSES
#endif // else defined(BigInt_RECURSES)
