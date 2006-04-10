(cl:in-package :R)
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |test_me|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("test_me" |test_me|) SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (COMMON-LISP:PROGN
   (SB-ALIEN:DEFINE-ALIEN-TYPE SEXPREC (SB-ALIEN:STRUCT SEXPREC)))
  (SB-ALIEN:DEFINE-ALIEN-TYPE SEXP (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |test_sexp_string|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("test_sexp_string" |test_sexp_string|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (|obj|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |test_sexp_type|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("test_sexp_type" |test_sexp_type|)
                                SB-ALIEN:UNSIGNED-INT
                                (|obj|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |setup_Rmainloop|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("setup_Rmainloop" |setup_Rmainloop|)
                                SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_initialize_R|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_initialize_R" |Rf_initialize_R|)
                                SB-ALIEN:INT
                                (|ac| SB-ALIEN:INT)
                                (|av|
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (COMMON-LISP:PROGN
   (SB-ALIEN:DEFINE-ALIEN-TYPE |ParseStatus|
                               (SB-ALIEN:ENUM COMMON-LISP:NIL
                                              (PARSE_NULL 0)
                                              (PARSE_OK 1)
                                              (PARSE_INCOMPLETE 2)
                                              (PARSE_ERROR 3)
                                              (PARSE_EOF 4)))
   (COMMON-LISP:DEFPARAMETER PARSE_NULL 0)
   (COMMON-LISP:DEFPARAMETER PARSE_OK 1)
   (COMMON-LISP:DEFPARAMETER PARSE_INCOMPLETE 2)
   (COMMON-LISP:DEFPARAMETER PARSE_ERROR 3)
   (COMMON-LISP:DEFPARAMETER PARSE_EOF 4)))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_ParseVector|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_ParseVector" |R_ParseVector|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 (COMMON-LISP:* |ParseStatus|)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_ScalarString|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_ScalarString" |Rf_ScalarString|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_ScalarReal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_ScalarReal" |Rf_ScalarReal|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |Rbyte| SB-ALIEN:UNSIGNED-CHAR)
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_ScalarRaw|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_ScalarRaw" |Rf_ScalarRaw|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:UNSIGNED-CHAR))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_ScalarLogical|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_ScalarLogical" |Rf_ScalarLogical|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_ScalarInteger|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_ScalarInteger" |Rf_ScalarInteger|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |Rcomplex|
                             (SB-ALIEN:STRUCT |Rcomplex|
                                              (|r| SB-ALIEN:DOUBLE
                                                   :ALIGNMENT
                                                   8)
                                              (|i| SB-ALIEN:DOUBLE
                                                   :ALIGNMENT
                                                   64)))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_ScalarComplex|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_ScalarComplex" |Rf_ScalarComplex|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 (SB-ALIEN:STRUCT |Rcomplex|)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_nlevels|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_nlevels" |Rf_nlevels|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_mkString|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_mkString" |Rf_mkString|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_mkChar|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_mkChar" |Rf_mkChar|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_listAppend|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_listAppend" |Rf_listAppend|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_list4|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_list4" |Rf_list4|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG4
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_list3|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_list3" |Rf_list3|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_list2|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_list2" |Rf_list2|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_list1|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_list1" |Rf_list1|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |R_len_t| SB-ALIEN:INT)
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_length|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_length" |Rf_length|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_lcons|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_lcons" |Rf_lcons|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_lastElt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_lastElt" |Rf_lastElt|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_lang4|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_lang4" |Rf_lang4|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG4
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_lang3|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_lang3" |Rf_lang3|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_lang2|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_lang2" |Rf_lang2|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_lang1|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_lang1" |Rf_lang1|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (SB-ALIEN:DEFINE-ALIEN-TYPE |Rboolean|
                              (SB-ALIEN:ENUM COMMON-LISP:NIL
                                             (FALSE 0)
                                             (TRUE 1)))
  (COMMON-LISP:DEFPARAMETER FALSE 0)
  (COMMON-LISP:DEFPARAMETER TRUE 1))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isVectorizable|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isVectorizable" |Rf_isVectorizable|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isVectorList|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isVectorList" |Rf_isVectorList|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isVectorAtomic|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isVectorAtomic" |Rf_isVectorAtomic|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isVector|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isVector" |Rf_isVector|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isValidStringF|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isValidStringF" |Rf_isValidStringF|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isValidString|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isValidString" |Rf_isValidString|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isUserBinop|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isUserBinop" |Rf_isUserBinop|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isUnordered|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isUnordered" |Rf_isUnordered|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isTs|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isTs" |Rf_isTs|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isSymbol|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isSymbol" |Rf_isSymbol|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isString|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isString" |Rf_isString|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isReal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isReal" |Rf_isReal|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isPrimitive|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isPrimitive" |Rf_isPrimitive|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isPairList|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isPairList" |Rf_isPairList|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isOrdered|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isOrdered" |Rf_isOrdered|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isObject|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isObject" |Rf_isObject|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isNumeric|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isNumeric" |Rf_isNumeric|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isNull|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isNull" |Rf_isNull|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isNewList|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isNewList" |Rf_isNewList|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isMatrix|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isMatrix" |Rf_isMatrix|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isLogical|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isLogical" |Rf_isLogical|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isList|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isList" |Rf_isList|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isLanguage|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isLanguage" |Rf_isLanguage|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isInteger|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isInteger" |Rf_isInteger|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isFrame|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isFrame" |Rf_isFrame|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isFactor|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isFactor" |Rf_isFactor|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isExpression|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isExpression" |Rf_isExpression|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isEnvironment|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isEnvironment" |Rf_isEnvironment|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isComplex|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isComplex" |Rf_isComplex|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isArray|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isArray" |Rf_isArray|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_inherits|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_inherits" |Rf_inherits|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_elt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_elt" |Rf_elt|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_conformable|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_conformable" |Rf_conformable|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_asReal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_asReal" |Rf_asReal|)
                                SB-ALIEN:DOUBLE
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_asLogical|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_asLogical" |Rf_asLogical|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_asInteger|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_asInteger" |Rf_asInteger|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_asComplex|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_asComplex" |Rf_asComplex|)
                                (SB-ALIEN:STRUCT |Rcomplex|)
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_allocString|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_allocString" |Rf_allocString|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_system|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_system" |R_system|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_RunExitFinalizers|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_RunExitFinalizers" |R_RunExitFinalizers|)
                                SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_dot_Last|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_dot_Last" |R_dot_Last|) SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_ReleaseObject|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_ReleaseObject" |R_ReleaseObject|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_PreserveObject|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_PreserveObject" |R_PreserveObject|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_seemsS4Object|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_seemsS4Object" |R_seemsS4Object|)
                                |Rboolean|
                                (|object|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_do_new_object|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_do_new_object" |R_do_new_object|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|class_def|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_do_MAKE_CLASS|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_do_MAKE_CLASS" |R_do_MAKE_CLASS|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|what| (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_do_slot_assign|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_do_slot_assign" |R_do_slot_assign|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|obj|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|name|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|value|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_do_slot|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_do_slot" |R_do_slot|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|obj|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|name|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (COMMON-LISP:PROGN
   (COMMON-LISP:PROGN
    (COMMON-LISP:PROGN
     (SB-ALIEN:DEFINE-ALIEN-TYPE |R_pstream_format_t|
                                 (SB-ALIEN:ENUM COMMON-LISP:NIL
                                                (|R_pstream_any_format| 0)
                                                (|R_pstream_ascii_format| 1)
                                                (|R_pstream_binary_format| 2)
                                                (|R_pstream_xdr_format| 3)))
     (COMMON-LISP:DEFPARAMETER |R_pstream_any_format| 0)
     (COMMON-LISP:DEFPARAMETER |R_pstream_ascii_format| 1)
     (COMMON-LISP:DEFPARAMETER |R_pstream_binary_format| 2)
     (COMMON-LISP:DEFPARAMETER |R_pstream_xdr_format| 3))
    (SB-ALIEN:DEFINE-ALIEN-TYPE |R_inpstream_st|
                                (SB-ALIEN:STRUCT |R_inpstream_st|
                                                 (|data|
                                                  (COMMON-LISP:* COMMON-LISP:T)
                                                  :ALIGNMENT
                                                  8)
                                                 (|type| |R_pstream_format_t|
                                                         :ALIGNMENT
                                                         32)
                                                 (|InChar|
                                                  (COMMON-LISP:*
                                                   (COMMON-LISP:FUNCTION
                                                    SB-ALIEN:INT
                                                    (COMMON-LISP:*
                                                     (SB-ALIEN:STRUCT
                                                      |R_inpstream_st|))))
                                                  :ALIGNMENT
                                                  64)
                                                 (|InBytes|
                                                  (COMMON-LISP:*
                                                   (COMMON-LISP:FUNCTION
                                                    SB-ALIEN:VOID
                                                    (COMMON-LISP:*
                                                     (SB-ALIEN:STRUCT
                                                      |R_inpstream_st|))
                                                    (COMMON-LISP:*
                                                     COMMON-LISP:T)
                                                    SB-ALIEN:INT))
                                                  :ALIGNMENT
                                                  32)
                                                 (|InPersistHookFunc|
                                                  (COMMON-LISP:*
                                                   (COMMON-LISP:FUNCTION
                                                    (COMMON-LISP:*
                                                     (SB-ALIEN:STRUCT SEXPREC))
                                                    (COMMON-LISP:*
                                                     (SB-ALIEN:STRUCT SEXPREC))
                                                    (COMMON-LISP:*
                                                     (SB-ALIEN:STRUCT
                                                      SEXPREC))))
                                                  :ALIGNMENT
                                                  64)
                                                 (|InPersistHookData|
                                                  (COMMON-LISP:*
                                                   (SB-ALIEN:STRUCT SEXPREC))
                                                  :ALIGNMENT
                                                  32)))))
  (SB-ALIEN:DEFINE-ALIEN-TYPE |R_inpstream_t|
                              (COMMON-LISP:*
                               (SB-ALIEN:STRUCT |R_inpstream_st|))))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_Unserialize|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_Unserialize" |R_Unserialize|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|ips|
                                 (COMMON-LISP:*
                                  (SB-ALIEN:STRUCT |R_inpstream_st|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (COMMON-LISP:PROGN
   (SB-ALIEN:DEFINE-ALIEN-TYPE |R_outpstream_st|
                               (SB-ALIEN:STRUCT |R_outpstream_st|
                                                (|data|
                                                 (COMMON-LISP:* COMMON-LISP:T)
                                                 :ALIGNMENT
                                                 8)
                                                (|type| |R_pstream_format_t|
                                                        :ALIGNMENT
                                                        32)
                                                (|version| SB-ALIEN:INT
                                                           :ALIGNMENT
                                                           64)
                                                (|OutChar|
                                                 (COMMON-LISP:*
                                                  (COMMON-LISP:FUNCTION
                                                   SB-ALIEN:VOID
                                                   (COMMON-LISP:*
                                                    (SB-ALIEN:STRUCT
                                                     |R_outpstream_st|))
                                                   SB-ALIEN:INT))
                                                 :ALIGNMENT
                                                 32)
                                                (|OutBytes|
                                                 (COMMON-LISP:*
                                                  (COMMON-LISP:FUNCTION
                                                   SB-ALIEN:VOID
                                                   (COMMON-LISP:*
                                                    (SB-ALIEN:STRUCT
                                                     |R_outpstream_st|))
                                                   (COMMON-LISP:*
                                                    COMMON-LISP:T)
                                                   SB-ALIEN:INT))
                                                 :ALIGNMENT
                                                 64)
                                                (|OutPersistHookFunc|
                                                 (COMMON-LISP:*
                                                  (COMMON-LISP:FUNCTION
                                                   (COMMON-LISP:*
                                                    (SB-ALIEN:STRUCT SEXPREC))
                                                   (COMMON-LISP:*
                                                    (SB-ALIEN:STRUCT SEXPREC))
                                                   (COMMON-LISP:*
                                                    (SB-ALIEN:STRUCT
                                                     SEXPREC))))
                                                 :ALIGNMENT
                                                 32)
                                                (|OutPersistHookData|
                                                 (COMMON-LISP:*
                                                  (SB-ALIEN:STRUCT SEXPREC))
                                                 :ALIGNMENT
                                                 64))))
  (SB-ALIEN:DEFINE-ALIEN-TYPE |R_outpstream_t|
                              (COMMON-LISP:*
                               (SB-ALIEN:STRUCT |R_outpstream_st|))))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_Serialize|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_Serialize" |R_Serialize|)
                                SB-ALIEN:VOID
                                (|s| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|ops|
                                 (COMMON-LISP:*
                                  (SB-ALIEN:STRUCT |R_outpstream_st|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (COMMON-LISP:PROGN
   (COMMON-LISP:PROGN
    (SB-ALIEN:DEFINE-ALIEN-TYPE |__sbuf|
                                (SB-ALIEN:STRUCT |__sbuf|
                                                 (|_base|
                                                  (COMMON-LISP:*
                                                   SB-ALIEN:UNSIGNED-CHAR)
                                                  :ALIGNMENT
                                                  8)
                                                 (|_size| SB-ALIEN:INT
                                                          :ALIGNMENT
                                                          32)))
    (COMMON-LISP:PROGN
     (COMMON-LISP:PROGN
      (SB-ALIEN:DEFINE-ALIEN-TYPE |__int64_t| (COMMON-LISP:INTEGER 64))
      (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_off_t| (COMMON-LISP:INTEGER 64)))
     (SB-ALIEN:DEFINE-ALIEN-TYPE |fpos_t| (COMMON-LISP:INTEGER 64)))
    (SB-ALIEN:DEFINE-ALIEN-TYPE |__sFILE|
                                (SB-ALIEN:STRUCT |__sFILE|
                                                 (|_p|
                                                  (COMMON-LISP:*
                                                   SB-ALIEN:UNSIGNED-CHAR)
                                                  :ALIGNMENT
                                                  8)
                                                 (|_r| SB-ALIEN:INT
                                                       :ALIGNMENT
                                                       32)
                                                 (|_w| SB-ALIEN:INT
                                                       :ALIGNMENT
                                                       64)
                                                 (|_flags| SB-ALIEN:SHORT
                                                           :ALIGNMENT
                                                           32)
                                                 (|_file| SB-ALIEN:SHORT
                                                          :ALIGNMENT
                                                          16)
                                                 (|_bf|
                                                  (SB-ALIEN:STRUCT |__sbuf|)
                                                  :ALIGNMENT
                                                  64)
                                                 (|_lbfsize| SB-ALIEN:INT
                                                             :ALIGNMENT
                                                             64)
                                                 (|_cookie|
                                                  (COMMON-LISP:* COMMON-LISP:T)
                                                  :ALIGNMENT
                                                  32)
                                                 (|_close|
                                                  (COMMON-LISP:*
                                                   (COMMON-LISP:FUNCTION
                                                    SB-ALIEN:INT
                                                    (COMMON-LISP:*
                                                     COMMON-LISP:T)))
                                                  :ALIGNMENT
                                                  64)
                                                 (|_read|
                                                  (COMMON-LISP:*
                                                   (COMMON-LISP:FUNCTION
                                                    SB-ALIEN:INT
                                                    (COMMON-LISP:*
                                                     COMMON-LISP:T)
                                                    (COMMON-LISP:*
                                                     COMMON-LISP:CHAR)
                                                    SB-ALIEN:INT))
                                                  :ALIGNMENT
                                                  32)
                                                 (|_seek|
                                                  (COMMON-LISP:*
                                                   (COMMON-LISP:FUNCTION
                                                    (COMMON-LISP:INTEGER 64)
                                                    (COMMON-LISP:*
                                                     COMMON-LISP:T)
                                                    (COMMON-LISP:INTEGER 64)
                                                    SB-ALIEN:INT))
                                                  :ALIGNMENT
                                                  64)
                                                 (|_write|
                                                  (COMMON-LISP:*
                                                   (COMMON-LISP:FUNCTION
                                                    SB-ALIEN:INT
                                                    (COMMON-LISP:*
                                                     COMMON-LISP:T)
                                                    (COMMON-LISP:*
                                                     COMMON-LISP:CHAR)
                                                    SB-ALIEN:INT))
                                                  :ALIGNMENT
                                                  32)
                                                 (|_ub|
                                                  (SB-ALIEN:STRUCT |__sbuf|)
                                                  :ALIGNMENT
                                                  64)
                                                 (|_extra|
                                                  (COMMON-LISP:*
                                                   (SB-ALIEN:STRUCT
                                                    |__sFILEX|))
                                                  :ALIGNMENT
                                                  64)
                                                 (|_ur| SB-ALIEN:INT
                                                        :ALIGNMENT
                                                        32)
                                                 (|_ubuf|
                                                  (COMMON-LISP:ARRAY
                                                   SB-ALIEN:UNSIGNED-CHAR
                                                   3)
                                                  :ALIGNMENT
                                                  64)
                                                 (|_nbuf|
                                                  (COMMON-LISP:ARRAY
                                                   SB-ALIEN:UNSIGNED-CHAR
                                                   1)
                                                  :ALIGNMENT
                                                  8)
                                                 (|_lb|
                                                  (SB-ALIEN:STRUCT |__sbuf|)
                                                  :ALIGNMENT
                                                  32)
                                                 (|_blksize| SB-ALIEN:INT
                                                             :ALIGNMENT
                                                             32)
                                                 (|_offset|
                                                  (COMMON-LISP:INTEGER 64)
                                                  :ALIGNMENT
                                                  64))))
   (SB-ALIEN:DEFINE-ALIEN-TYPE FILE (SB-ALIEN:STRUCT |__sFILE|))))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_InitFileOutPStream|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_InitFileOutPStream" |R_InitFileOutPStream|)
                                SB-ALIEN:VOID
                                (|stream|
                                 (COMMON-LISP:*
                                  (SB-ALIEN:STRUCT |R_outpstream_st|)))
                                (|fp|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (|type| |R_pstream_format_t|)
                                (|version| SB-ALIEN:INT)
                                (|phook|
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))))
                                (|pdata|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_InitFileInPStream|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_InitFileInPStream" |R_InitFileInPStream|)
                                SB-ALIEN:VOID
                                (|stream|
                                 (COMMON-LISP:*
                                  (SB-ALIEN:STRUCT |R_inpstream_st|)))
                                (|fp|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (|type| |R_pstream_format_t|)
                                (|phook|
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))))
                                (|pdata|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |R_pstream_data_t| (COMMON-LISP:* COMMON-LISP:T))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_InitOutPStream|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_InitOutPStream" |R_InitOutPStream|)
                                SB-ALIEN:VOID
                                (|stream|
                                 (COMMON-LISP:*
                                  (SB-ALIEN:STRUCT |R_outpstream_st|)))
                                (|data| (COMMON-LISP:* COMMON-LISP:T))
                                (|type| |R_pstream_format_t|)
                                (|version| SB-ALIEN:INT)
                                (|outchar|
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:VOID
                                   (COMMON-LISP:*
                                    (SB-ALIEN:STRUCT |R_outpstream_st|))
                                   SB-ALIEN:INT)))
                                (|outbytes|
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:VOID
                                   (COMMON-LISP:*
                                    (SB-ALIEN:STRUCT |R_outpstream_st|))
                                   (COMMON-LISP:* COMMON-LISP:T)
                                   SB-ALIEN:INT)))
                                (|phook|
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))))
                                (|pdata|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_InitInPStream|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_InitInPStream" |R_InitInPStream|)
                                SB-ALIEN:VOID
                                (|stream|
                                 (COMMON-LISP:*
                                  (SB-ALIEN:STRUCT |R_inpstream_st|)))
                                (|data| (COMMON-LISP:* COMMON-LISP:T))
                                (|type| |R_pstream_format_t|)
                                (|inchar|
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:INT
                                   (COMMON-LISP:*
                                    (SB-ALIEN:STRUCT |R_inpstream_st|)))))
                                (|inbytes|
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:VOID
                                   (COMMON-LISP:*
                                    (SB-ALIEN:STRUCT |R_inpstream_st|))
                                   (COMMON-LISP:* COMMON-LISP:T)
                                   SB-ALIEN:INT)))
                                (|phook|
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))))
                                (|pdata|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_XDRDecodeInteger|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_XDRDecodeInteger" |R_XDRDecodeInteger|)
                                SB-ALIEN:INT
                                (|buf| (COMMON-LISP:* COMMON-LISP:T)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_XDREncodeInteger|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_XDREncodeInteger" |R_XDREncodeInteger|)
                                SB-ALIEN:VOID
                                (|i| SB-ALIEN:INT)
                                (|buf| (COMMON-LISP:* COMMON-LISP:T)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_XDRDecodeDouble|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_XDRDecodeDouble" |R_XDRDecodeDouble|)
                                SB-ALIEN:DOUBLE
                                (|buf| (COMMON-LISP:* COMMON-LISP:T)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_XDREncodeDouble|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_XDREncodeDouble" |R_XDREncodeDouble|)
                                SB-ALIEN:VOID
                                (|d| SB-ALIEN:DOUBLE)
                                (|buf| (COMMON-LISP:* COMMON-LISP:T)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_SetUseNamespaceDispatch|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("R_SetUseNamespaceDispatch" |R_SetUseNamespaceDispatch|)
  SB-ALIEN:VOID
  (|val| |Rboolean|))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_warningcall|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_warningcall" |Rf_warningcall|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_errorcall|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_errorcall" |Rf_errorcall|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_HasFancyBindings|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_HasFancyBindings" |R_HasFancyBindings|)
                                |Rboolean|
                                (|rho|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_BindingIsActive|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_BindingIsActive" |R_BindingIsActive|)
                                |Rboolean|
                                (|sym|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|env|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_BindingIsLocked|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_BindingIsLocked" |R_BindingIsLocked|)
                                |Rboolean|
                                (|sym|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|env|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_MakeActiveBinding|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_MakeActiveBinding" |R_MakeActiveBinding|)
                                SB-ALIEN:VOID
                                (|sym|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|fun|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|env|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_LockBinding|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_LockBinding" |R_LockBinding|)
                                SB-ALIEN:VOID
                                (|sym|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|env|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_EnvironmentIsLocked|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("R_EnvironmentIsLocked" |R_EnvironmentIsLocked|)
  |Rboolean|
  (|env| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_LockEnvironment|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_LockEnvironment" |R_LockEnvironment|)
                                SB-ALIEN:VOID
                                (|env|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|bindings| |Rboolean|))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_FindNamespace|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_FindNamespace" |R_FindNamespace|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|info|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_NamespaceEnvSpec|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_NamespaceEnvSpec" |R_NamespaceEnvSpec|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|rho|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_IsNamespaceEnv|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_IsNamespaceEnv" |R_IsNamespaceEnv|)
                                |Rboolean|
                                (|rho|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_FindPackageEnv|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_FindPackageEnv" |R_FindPackageEnv|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|info|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_PackageEnvName|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_PackageEnvName" |R_PackageEnvName|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|rho|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_IsPackageEnv|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_IsPackageEnv" |R_IsPackageEnv|)
                                |Rboolean|
                                (|rho|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_RestoreHashCount|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_RestoreHashCount" |R_RestoreHashCount|)
                                SB-ALIEN:VOID
                                (|rho|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_ToplevelExec|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_ToplevelExec" |R_ToplevelExec|)
                                |Rboolean|
                                (|fun|
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:VOID
                                   (COMMON-LISP:* COMMON-LISP:T))))
                                (|data| (COMMON-LISP:* COMMON-LISP:T)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_RunWeakRefFinalizer|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("R_RunWeakRefFinalizer" |R_RunWeakRefFinalizer|)
  SB-ALIEN:VOID
  (|w| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_WeakRefValue|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_WeakRefValue" |R_WeakRefValue|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|w|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_WeakRefKey|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_WeakRefKey" |R_WeakRefKey|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|w|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |R_CFinalizer_t|
                             (COMMON-LISP:*
                              (COMMON-LISP:FUNCTION SB-ALIEN:VOID
                               (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_MakeWeakRefC|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_MakeWeakRefC" |R_MakeWeakRefC|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|key|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|val|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|fin|
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:VOID
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))))
                                (|onexit| |Rboolean|))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_MakeWeakRef|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_MakeWeakRef" |R_MakeWeakRef|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|key|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|val|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|fin|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|onexit| |Rboolean|))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_RegisterCFinalizerEx|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("R_RegisterCFinalizerEx" |R_RegisterCFinalizerEx|)
  SB-ALIEN:VOID
  (|s| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
  (|fun|
   (COMMON-LISP:*
    (COMMON-LISP:FUNCTION SB-ALIEN:VOID
     (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))))
  (|onexit| |Rboolean|))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_RegisterFinalizerEx|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("R_RegisterFinalizerEx" |R_RegisterFinalizerEx|)
  SB-ALIEN:VOID
  (|s| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
  (|fun| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
  (|onexit| |Rboolean|))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_RegisterCFinalizer|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_RegisterCFinalizer" |R_RegisterCFinalizer|)
                                SB-ALIEN:VOID
                                (|s| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|fun|
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:VOID
                                   (COMMON-LISP:*
                                    (SB-ALIEN:STRUCT SEXPREC))))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_RegisterFinalizer|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_RegisterFinalizer" |R_RegisterFinalizer|)
                                SB-ALIEN:VOID
                                (|s| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|fun|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_SetExternalPtrProtected|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("R_SetExternalPtrProtected" |R_SetExternalPtrProtected|)
  SB-ALIEN:VOID
  (|s| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
  (|p| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_SetExternalPtrTag|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_SetExternalPtrTag" |R_SetExternalPtrTag|)
                                SB-ALIEN:VOID
                                (|s| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|tag|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_SetExternalPtrAddr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_SetExternalPtrAddr" |R_SetExternalPtrAddr|)
                                SB-ALIEN:VOID
                                (|s| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|p| (COMMON-LISP:* COMMON-LISP:T)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_ClearExternalPtr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_ClearExternalPtr" |R_ClearExternalPtr|)
                                SB-ALIEN:VOID
                                (|s|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_ExternalPtrProtected|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("R_ExternalPtrProtected" |R_ExternalPtrProtected|)
  (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
  (|s| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_ExternalPtrTag|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_ExternalPtrTag" |R_ExternalPtrTag|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|s|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_ExternalPtrAddr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_ExternalPtrAddr" |R_ExternalPtrAddr|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (|s|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_MakeExternalPtr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_MakeExternalPtr" |R_MakeExternalPtr|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|p| (COMMON-LISP:* COMMON-LISP:T))
                                (|tag|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|prot|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_subset3_dflt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_subset3_dflt" |R_subset3_dflt|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_subassign3_dflt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_subassign3_dflt" |R_subassign3_dflt|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG4
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE PROTECT_INDEX SB-ALIEN:INT)
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_Reprotect|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_Reprotect" |R_Reprotect|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_ProtectWithIndex|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_ProtectWithIndex" |R_ProtectWithIndex|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_vectorSubscript|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_vectorSubscript" |Rf_vectorSubscript|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:INT)
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG4
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))))
                                (ARG5
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   SB-ALIEN:INT)))
                                (ARG6
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_unprotect_ptr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_unprotect_ptr" |Rf_unprotect_ptr|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_unprotect|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_unprotect" |Rf_unprotect|)
                                SB-ALIEN:VOID
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_tryEval|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_tryEval" |R_tryEval|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|e| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|env|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|ErrorOccurred| (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_substitute|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_substitute" |Rf_substitute|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_StringBlank|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_StringBlank" |Rf_StringBlank|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_setVar|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_setVar" |Rf_setVar|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_setSVector|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_setSVector" |Rf_setSVector|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_setAttrib|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_setAttrib" |Rf_setAttrib|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_rownamesgets|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_rownamesgets" |Rf_rownamesgets|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_protect|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_protect" |Rf_protect|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_PrintValueRec|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_PrintValueRec" |Rf_PrintValueRec|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_PrintValueEnv|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_PrintValueEnv" |Rf_PrintValueEnv|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_PrintValue|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_PrintValue" |Rf_PrintValue|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_PrintDefaults|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_PrintDefaults" |Rf_PrintDefaults|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_psmatch|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_psmatch" |Rf_psmatch|)
                                |Rboolean|
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 |Rboolean|))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_pmatch|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_pmatch" |Rf_pmatch|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3 |Rboolean|))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_nthcdr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_nthcdr" |Rf_nthcdr|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_nrows|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_nrows" |Rf_nrows|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_ncols|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_ncols" |Rf_ncols|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_NonNullStringMatch|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("Rf_NonNullStringMatch" |Rf_NonNullStringMatch|)
  |Rboolean|
  (ARG1 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
  (ARG2 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_namesgets|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_namesgets" |Rf_namesgets|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_matchPar|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_matchPar" |Rf_matchPar|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_matchArgs|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_matchArgs" |Rf_matchArgs|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_matchArgExact|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_matchArgExact" |Rf_matchArgExact|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_matchArg|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_matchArg" |Rf_matchArg|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_match|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_match" |Rf_match|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_makeSubscript|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_makeSubscript" |Rf_makeSubscript|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_lsInternal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_lsInternal" |R_lsInternal|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 |Rboolean|))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_lengthgets|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_lengthgets" |Rf_lengthgets|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_ItemName|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_ItemName" |Rf_ItemName|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isUnsorted|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isUnsorted" |Rf_isUnsorted|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isFunction|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isFunction" |Rf_isFunction|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isFree|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isFree" |Rf_isFree|)
                                |Rboolean|
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_install|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_install" |Rf_install|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_gsetVar|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_gsetVar" |Rf_gsetVar|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_GetRowNames|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_GetRowNames" |Rf_GetRowNames|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_GetOptionWidth|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_GetOptionWidth" |Rf_GetOptionWidth|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_GetOptionDigits|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_GetOptionDigits" |Rf_GetOptionDigits|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_GetOption|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_GetOption" |Rf_GetOption|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_GetMatrixDimnames|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_GetMatrixDimnames" |Rf_GetMatrixDimnames|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))
                                (ARG3
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))
                                (ARG4
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG5
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_GetColNames|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_GetColNames" |Rf_GetColNames|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_GetArrayDimnames|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_GetArrayDimnames" |Rf_GetArrayDimnames|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_getAttrib|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_getAttrib" |Rf_getAttrib|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_findVarInFrame3|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_findVarInFrame3" |Rf_findVarInFrame3|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3 |Rboolean|))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_findVarInFrame|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_findVarInFrame" |Rf_findVarInFrame|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_findVar|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_findVar" |Rf_findVar|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_findFun|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_findFun" |Rf_findFun|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_evalListKeepMissing|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("Rf_evalListKeepMissing" |Rf_evalListKeepMissing|)
  (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
  (ARG1 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
  (ARG2 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_evalList|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_evalList" |Rf_evalList|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_EvalArgs|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_EvalArgs" |Rf_EvalArgs|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_eval|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_eval" |Rf_eval|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_duplicated|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_duplicated" |Rf_duplicated|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_duplicate|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_duplicate" |Rf_duplicate|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_DropDims|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_DropDims" |Rf_DropDims|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_dimnamesgets|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_dimnamesgets" |Rf_dimnamesgets|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_dimgets|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_dimgets" |Rf_dimgets|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_defineVar|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_defineVar" |Rf_defineVar|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_CustomPrintValue|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_CustomPrintValue" |Rf_CustomPrintValue|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_CreateTag|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_CreateTag" |Rf_CreateTag|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_copyVector|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_copyVector" |Rf_copyVector|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_copyMostAttribNoTs|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("Rf_copyMostAttribNoTs" |Rf_copyMostAttribNoTs|)
  SB-ALIEN:VOID
  (ARG1 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
  (ARG2 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_copyMostAttrib|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_copyMostAttrib" |Rf_copyMostAttrib|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_copyMatrix|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_copyMatrix" |Rf_copyMatrix|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3 |Rboolean|))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_copyListMatrix|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_copyListMatrix" |Rf_copyListMatrix|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3 |Rboolean|))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_cons|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_cons" |Rf_cons|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_classgets|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_classgets" |Rf_classgets|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_asVecSize|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_asVecSize" |Rf_asVecSize|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_arraySubscript|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_arraySubscript" |Rf_arraySubscript|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:INT)
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG4
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))))
                                (ARG5
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                   SB-ALIEN:INT)))
                                (ARG6
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_applyClosure|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_applyClosure" |Rf_applyClosure|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG4
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG5
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE SEXPTYPE SB-ALIEN:UNSIGNED-INT)
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_allocVector|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_allocVector" |Rf_allocVector|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:UNSIGNED-INT)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_allocSExp|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_allocSExp" |Rf_allocSExp|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_allocList|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_allocList" |Rf_allocList|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_allocMatrix|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_allocMatrix" |Rf_allocMatrix|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:UNSIGNED-INT)
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_allocArray|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_allocArray" |Rf_allocArray|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:UNSIGNED-INT)
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_EnsureString|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_EnsureString" |Rf_EnsureString|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_StringFromComplex|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_StringFromComplex" |Rf_StringFromComplex|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 (SB-ALIEN:STRUCT |Rcomplex|))
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_StringFromReal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_StringFromReal" |Rf_StringFromReal|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_StringFromInteger|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_StringFromInteger" |Rf_StringFromInteger|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_StringFromLogical|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_StringFromLogical" |Rf_StringFromLogical|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_ComplexFromString|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_ComplexFromString" |Rf_ComplexFromString|)
                                (SB-ALIEN:STRUCT |Rcomplex|)
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_ComplexFromReal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_ComplexFromReal" |Rf_ComplexFromReal|)
                                (SB-ALIEN:STRUCT |Rcomplex|)
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_ComplexFromInteger|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("Rf_ComplexFromInteger" |Rf_ComplexFromInteger|)
  (SB-ALIEN:STRUCT |Rcomplex|)
  (ARG1 SB-ALIEN:INT)
  (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_ComplexFromLogical|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("Rf_ComplexFromLogical" |Rf_ComplexFromLogical|)
  (SB-ALIEN:STRUCT |Rcomplex|)
  (ARG1 SB-ALIEN:INT)
  (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_RealFromString|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_RealFromString" |Rf_RealFromString|)
                                SB-ALIEN:DOUBLE
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_RealFromComplex|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_RealFromComplex" |Rf_RealFromComplex|)
                                SB-ALIEN:DOUBLE
                                (ARG1 (SB-ALIEN:STRUCT |Rcomplex|))
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_RealFromInteger|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_RealFromInteger" |Rf_RealFromInteger|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_RealFromLogical|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_RealFromLogical" |Rf_RealFromLogical|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_IntegerFromString|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_IntegerFromString" |Rf_IntegerFromString|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_IntegerFromComplex|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("Rf_IntegerFromComplex" |Rf_IntegerFromComplex|)
  SB-ALIEN:INT
  (ARG1 (SB-ALIEN:STRUCT |Rcomplex|))
  (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_IntegerFromReal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_IntegerFromReal" |Rf_IntegerFromReal|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_IntegerFromLogical|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("Rf_IntegerFromLogical" |Rf_IntegerFromLogical|)
  SB-ALIEN:INT
  (ARG1 SB-ALIEN:INT)
  (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_LogicalFromString|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_LogicalFromString" |Rf_LogicalFromString|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_LogicalFromComplex|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("Rf_LogicalFromComplex" |Rf_LogicalFromComplex|)
  SB-ALIEN:INT
  (ARG1 (SB-ALIEN:STRUCT |Rcomplex|))
  (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_LogicalFromReal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_LogicalFromReal" |Rf_LogicalFromReal|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_LogicalFromInteger|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("Rf_LogicalFromInteger" |Rf_LogicalFromInteger|)
  SB-ALIEN:INT
  (ARG1 SB-ALIEN:INT)
  (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_VectorToPairList|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_VectorToPairList" |Rf_VectorToPairList|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_PairToVectorList|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_PairToVectorList" |Rf_PairToVectorList|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_CoercionWarning|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_CoercionWarning" |Rf_CoercionWarning|)
                                SB-ALIEN:VOID
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_coerceList|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_coerceList" |Rf_coerceList|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_coerceVector|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_coerceVector" |Rf_coerceVector|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2 SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_ascommon|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_ascommon" |Rf_ascommon|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (ARG3 SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_asChar|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_asChar" |Rf_asChar|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_BlankString" |R_BlankString|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_NaString" |R_NaString|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_UseNamesSymbol" |R_UseNamesSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_RecursiveSymbol" |R_RecursiveSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_DotEnvSymbol" |R_DotEnvSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_SourceSymbol" |R_SourceSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_CommentSymbol" |R_CommentSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_LastvalueSymbol" |R_LastvalueSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_TspSymbol" |R_TspSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_SeedsSymbol" |R_SeedsSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_RowNamesSymbol" |R_RowNamesSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_NaRmSymbol" |R_NaRmSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_NamesSymbol" |R_NamesSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_ModeSymbol" |R_ModeSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_LevelsSymbol" |R_LevelsSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_DropSymbol" |R_DropSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_DotsSymbol" |R_DotsSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_DollarSymbol" |R_DollarSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_DimSymbol" |R_DimSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_DimNamesSymbol" |R_DimNamesSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_ClassSymbol" |R_ClassSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_TmpvalSymbol" |R_TmpvalSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_BraceSymbol" |R_BraceSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_BracketSymbol" |R_BracketSymbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_Bracket2Symbol" |R_Bracket2Symbol|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_RestartToken" |R_RestartToken|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_MissingArg" |R_MissingArg|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_UnboundValue" |R_UnboundValue|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_NilValue" |R_NilValue|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_NamespaceRegistry" |R_NamespaceRegistry|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_BaseNamespace" |R_BaseNamespace|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_BaseEnv" |R_BaseEnv|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_EmptyEnv" |R_EmptyEnv|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_GlobalEnv" |R_GlobalEnv|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_HASHVALUE))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_HASHVALUE" SET_HASHVALUE)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_HASHASH))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_HASHASH" SET_HASHASH)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE HASHVALUE))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("HASHVALUE" HASHVALUE)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE HASHASH))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("HASHASH" HASHASH)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_PRCODE))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_PRCODE" SET_PRCODE)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_PRVALUE))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_PRVALUE" SET_PRVALUE)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_PRENV))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_PRENV" SET_PRENV)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_PRSEEN))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_PRSEEN" SET_PRSEEN)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE PRSEEN))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("PRSEEN" PRSEEN)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE PRVALUE))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("PRVALUE" PRVALUE)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE PRENV))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("PRENV" PRENV)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE PRCODE))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("PRCODE" PRCODE)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_HASHTAB))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_HASHTAB" SET_HASHTAB)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_ENCLOS))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_ENCLOS" SET_ENCLOS)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_FRAME))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_FRAME" SET_FRAME)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_ENVFLAGS))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_ENVFLAGS" SET_ENVFLAGS)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE ENVFLAGS))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ENVFLAGS" ENVFLAGS)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE HASHTAB))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("HASHTAB" HASHTAB)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE ENCLOS))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ENCLOS" ENCLOS)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE FRAME))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("FRAME" FRAME)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_INTERNAL))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_INTERNAL" SET_INTERNAL)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_SYMVALUE))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_SYMVALUE" SET_SYMVALUE)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_PRINTNAME))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_PRINTNAME" SET_PRINTNAME)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_DDVAL))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_DDVAL" SET_DDVAL)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE DDVAL))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("DDVAL" DDVAL)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE INTERNAL))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("INTERNAL" INTERNAL)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SYMVALUE))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SYMVALUE" SYMVALUE)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE PRINTNAME))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("PRINTNAME" PRINTNAME)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_CLOENV))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_CLOENV" SET_CLOENV)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_BODY))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_BODY" SET_BODY)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_FORMALS))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_FORMALS" SET_FORMALS)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_TRACE))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_TRACE" SET_TRACE)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_DEBUG))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_DEBUG" SET_DEBUG)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE TRACE))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("TRACE" TRACE)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE DEBUG))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("DEBUG" DEBUG)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE CLOENV))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("CLOENV" CLOENV)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE BODY))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("BODY" BODY)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE FORMALS))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("FORMALS" FORMALS)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SETCAD4R))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SETCAD4R" SETCAD4R)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|e| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|y|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SETCADDDR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SETCADDDR" SETCADDDR)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|y|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SETCADDR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SETCADDR" SETCADDR)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|y|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SETCADR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SETCADR" SETCADR)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|y|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SETCDR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SETCDR" SETCDR)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|y|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SETCAR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SETCAR" SETCAR)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|y|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_TAG))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_TAG" SET_TAG)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|y|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_MISSING))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_MISSING" SET_MISSING)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE MISSING))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("MISSING" MISSING)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE CAD4R))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("CAD4R" CAD4R)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|e|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE CADDDR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("CADDDR" CADDDR)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|e|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE CADDR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("CADDR" CADDR)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|e|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE CDDR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("CDDR" CDDR)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|e|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE CADR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("CADR" CADR)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|e|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE CDAR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("CDAR" CDAR)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|e|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE CAAR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("CAAR" CAAR)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|e|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE CDR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("CDR" CDR)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|e|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE CAR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("CAR" CAR)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|e|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE TAG))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("TAG" TAG)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|e|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE VECTOR_PTR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("VECTOR_PTR" VECTOR_PTR)
                                (COMMON-LISP:*
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE STRING_PTR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("STRING_PTR" STRING_PTR)
                                (COMMON-LISP:*
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_VECTOR_ELT))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_VECTOR_ELT" SET_VECTOR_ELT)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|i| SB-ALIEN:INT)
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_STRING_ELT))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_STRING_ELT" SET_STRING_ELT)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|i| SB-ALIEN:INT)
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE VECTOR_ELT))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("VECTOR_ELT" VECTOR_ELT)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|i| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE STRING_ELT))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("STRING_ELT" STRING_ELT)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|i| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE COMPLEX))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("COMPLEX" COMPLEX)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT |Rcomplex|))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE REAL))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("REAL" REAL)
                                (COMMON-LISP:* SB-ALIEN:DOUBLE)
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE RAW))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("RAW" RAW)
                                (COMMON-LISP:* SB-ALIEN:UNSIGNED-CHAR)
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE INTEGER))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("INTEGER" INTEGER)
                                (COMMON-LISP:* SB-ALIEN:INT)
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE LOGICAL))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("LOGICAL" LOGICAL)
                                (COMMON-LISP:* SB-ALIEN:INT)
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SETLEVELS))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SETLEVELS" SETLEVELS)
                                SB-ALIEN:INT
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE LEVELS))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("LEVELS" LEVELS)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_TRUELENGTH))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_TRUELENGTH" SET_TRUELENGTH)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SETLENGTH))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SETLENGTH" SETLENGTH)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE TRUELENGTH))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("TRUELENGTH" TRUELENGTH)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE LENGTH))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("LENGTH" LENGTH)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_ATTRIB))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_ATTRIB" SET_ATTRIB)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_NAMED))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_NAMED" SET_NAMED)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_TYPEOF))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_TYPEOF" SET_TYPEOF)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE SET_OBJECT))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("SET_OBJECT" SET_OBJECT)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC)))
                                (|v| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE NAMED))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("NAMED" NAMED)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE TYPEOF))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("TYPEOF" TYPEOF)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE MARK))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("MARK" MARK)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE OBJECT))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("OBJECT" OBJECT)
                                SB-ALIEN:INT
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE ATTRIB))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ATTRIB" ATTRIB)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE R_CHAR))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_CHAR" R_CHAR)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (|x|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT SEXPREC))))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_ct_rune_t| SB-ALIEN:INT)
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__wcwidth|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__wcwidth" |__wcwidth|)
                                SB-ALIEN:INT
                                (|_c| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__tolower|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__tolower" |__tolower|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__toupper|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__toupper" |__toupper|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__isctype|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__isctype" |__isctype|)
                                SB-ALIEN:INT
                                (|_c| SB-ALIEN:INT)
                                (|_f| SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__istype|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__istype" |__istype|)
                                SB-ALIEN:INT
                                (|_c| SB-ALIEN:INT)
                                (|_f| SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__maskrune|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__maskrune" |__maskrune|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |___toupper|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("___toupper" |___toupper|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |___tolower|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("___tolower" |___tolower|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |___runetype|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("___runetype" |___runetype|)
                                SB-ALIEN:UNSIGNED-LONG
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isspecial|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isspecial" |isspecial|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isrune|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isrune" |isrune|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isphonogram|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isphonogram" |isphonogram|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isnumber|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isnumber" |isnumber|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isideogram|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isideogram" |isideogram|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ishexnumber|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ishexnumber" |ishexnumber|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |digittoint|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("digittoint" |digittoint|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |_toupper|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("_toupper" |_toupper|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |_tolower|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("_tolower" |_tolower|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |toascii|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("toascii" |toascii|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isascii|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isascii" |isascii|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |toupper|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("toupper" |toupper|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |tolower|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("tolower" |tolower|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isxdigit|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isxdigit" |isxdigit|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isupper|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isupper" |isupper|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isspace|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isspace" |isspace|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ispunct|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ispunct" |ispunct|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isprint|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isprint" |isprint|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |islower|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("islower" |islower|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isgraph|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isgraph" |isgraph|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isdigit|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isdigit" |isdigit|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |iscntrl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("iscntrl" |iscntrl|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isblank|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isblank" |isblank|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isalpha|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isalpha" |isalpha|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |isalnum|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("isalnum" |isalnum|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (COMMON-LISP:PROGN
   (COMMON-LISP:PROGN
    (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_wchar_t| SB-ALIEN:INT)
    (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_rune_t| SB-ALIEN:INT))
   (COMMON-LISP:PROGN
    (SB-ALIEN:DEFINE-ALIEN-TYPE |__uint32_t| SB-ALIEN:UNSIGNED-INT))
   (SB-ALIEN:DEFINE-ALIEN-TYPE |_RuneRange|
                               (SB-ALIEN:STRUCT |_RuneRange|
                                                (|__nranges| SB-ALIEN:INT
                                                             :ALIGNMENT
                                                             8)
                                                (|__ranges|
                                                 (COMMON-LISP:*
                                                  (SB-ALIEN:STRUCT
                                                   |_RuneEntry|))
                                                 :ALIGNMENT
                                                 32)))
   (SB-ALIEN:DEFINE-ALIEN-TYPE |_RuneLocale|
                               (SB-ALIEN:STRUCT |_RuneLocale|
                                                (|__magic|
                                                 (COMMON-LISP:ARRAY
                                                  COMMON-LISP:CHAR
                                                  8)
                                                 :ALIGNMENT
                                                 8)
                                                (|__encoding|
                                                 (COMMON-LISP:ARRAY
                                                  COMMON-LISP:CHAR
                                                  32)
                                                 :ALIGNMENT
                                                 64)
                                                (|__sgetrune|
                                                 (COMMON-LISP:*
                                                  (COMMON-LISP:FUNCTION
                                                   SB-ALIEN:INT
                                                   (COMMON-LISP:*
                                                    COMMON-LISP:CHAR)
                                                   SB-ALIEN:UNSIGNED-LONG
                                                   (COMMON-LISP:*
                                                    (COMMON-LISP:*
                                                     COMMON-LISP:CHAR))))
                                                 :ALIGNMENT
                                                 64)
                                                (|__sputrune|
                                                 (COMMON-LISP:*
                                                  (COMMON-LISP:FUNCTION
                                                   SB-ALIEN:INT SB-ALIEN:INT
                                                   (COMMON-LISP:*
                                                    COMMON-LISP:CHAR)
                                                   SB-ALIEN:UNSIGNED-LONG
                                                   (COMMON-LISP:*
                                                    (COMMON-LISP:*
                                                     COMMON-LISP:CHAR))))
                                                 :ALIGNMENT
                                                 32)
                                                (|__invalid_rune| SB-ALIEN:INT
                                                                  :ALIGNMENT
                                                                  64)
                                                (|__runetype|
                                                 (COMMON-LISP:ARRAY
                                                  SB-ALIEN:UNSIGNED-INT
                                                  256)
                                                 :ALIGNMENT
                                                 32)
                                                (|__maplower|
                                                 (COMMON-LISP:ARRAY
                                                  SB-ALIEN:INT
                                                  256)
                                                 :ALIGNMENT
                                                 32)
                                                (|__mapupper|
                                                 (COMMON-LISP:ARRAY
                                                  SB-ALIEN:INT
                                                  256)
                                                 :ALIGNMENT
                                                 32)
                                                (|__runetype_ext|
                                                 (SB-ALIEN:STRUCT |_RuneRange|)
                                                 :ALIGNMENT
                                                 32)
                                                (|__maplower_ext|
                                                 (SB-ALIEN:STRUCT |_RuneRange|)
                                                 :ALIGNMENT
                                                 32)
                                                (|__mapupper_ext|
                                                 (SB-ALIEN:STRUCT |_RuneRange|)
                                                 :ALIGNMENT
                                                 32)
                                                (|__variable|
                                                 (COMMON-LISP:* COMMON-LISP:T)
                                                 :ALIGNMENT
                                                 32)
                                                (|__variable_len| SB-ALIEN:INT
                                                                  :ALIGNMENT
                                                                  64)))))
 (SB-ALIEN:DEFINE-ALIEN-VARIABLE ("_CurrentRuneLocale" |_CurrentRuneLocale|)
                                 (COMMON-LISP:*
                                  (SB-ALIEN:STRUCT |_RuneLocale|)))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("_DefaultRuneLocale" |_DefaultRuneLocale|)
                                (SB-ALIEN:STRUCT |_RuneLocale|)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |_RuneEntry|
                            (SB-ALIEN:STRUCT |_RuneEntry|
                                             (|__min| SB-ALIEN:INT
                                                      :ALIGNMENT
                                                      8)
                                             (|__max| SB-ALIEN:INT
                                                      :ALIGNMENT
                                                      32)
                                             (|__map| SB-ALIEN:INT
                                                      :ALIGNMENT
                                                      64)
                                             (|__types|
                                              (COMMON-LISP:*
                                               SB-ALIEN:UNSIGNED-INT)
                                              :ALIGNMENT
                                              32))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_wint_t| SB-ALIEN:INT)
 (SB-ALIEN:DEFINE-ALIEN-TYPE |wint_t| SB-ALIEN:INT)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__error|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__error" |__error|)
                                (COMMON-LISP:* SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_printComplexVector|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("Rf_printComplexVector" |Rf_printComplexVector|)
  SB-ALIEN:VOID
  (|x| (COMMON-LISP:* (SB-ALIEN:STRUCT |Rcomplex|)))
  (|n| SB-ALIEN:INT)
  (|indx| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_printRealVector|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_printRealVector" |Rf_printRealVector|)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (|n| SB-ALIEN:INT)
                                (|indx| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_printIntegerVector|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE
  ("Rf_printIntegerVector" |Rf_printIntegerVector|)
  SB-ALIEN:VOID
  (|x| (COMMON-LISP:* SB-ALIEN:INT))
  (|n| SB-ALIEN:INT)
  (|indx| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |printLogicalVector|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("printLogicalVector" |printLogicalVector|)
                                SB-ALIEN:VOID
                                (|x| (COMMON-LISP:* SB-ALIEN:INT))
                                (|n| SB-ALIEN:INT)
                                (|indx| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_VectorIndex|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_VectorIndex" |Rf_VectorIndex|)
                                SB-ALIEN:VOID
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_EncodeComplex|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_EncodeComplex" |Rf_EncodeComplex|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (SB-ALIEN:STRUCT |Rcomplex|))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 SB-ALIEN:INT)
                                (ARG4 SB-ALIEN:INT)
                                (ARG5 SB-ALIEN:INT)
                                (ARG6 SB-ALIEN:INT)
                                (ARG7 SB-ALIEN:INT)
                                (ARG8 COMMON-LISP:CHAR))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_EncodeReal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_EncodeReal" |Rf_EncodeReal|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 SB-ALIEN:INT)
                                (ARG4 SB-ALIEN:INT)
                                (ARG5 COMMON-LISP:CHAR))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_EncodeInteger|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_EncodeInteger" |Rf_EncodeInteger|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_EncodeLogical|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_EncodeLogical" |Rf_EncodeLogical|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_formatComplex|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_formatComplex" |Rf_formatComplex|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |Rcomplex|)))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG4 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG5 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG6 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG7 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG8 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG9 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_formatReal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_formatReal" |Rf_formatReal|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG4 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG5 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG6 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_formatInteger|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_formatInteger" |Rf_formatInteger|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_formatLogical|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_formatLogical" |Rf_formatLogical|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_ProcessEvents|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_ProcessEvents" |R_ProcessEvents|)
                                SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_FlushConsole|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_FlushConsole" |R_FlushConsole|)
                                SB-ALIEN:VOID)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |Sint| SB-ALIEN:INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |Sfloat| SB-ALIEN:DOUBLE) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |call_R|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("call_R" |call_R|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 SB-ALIEN:LONG)
                                (ARG3
                                 (COMMON-LISP:* (COMMON-LISP:* COMMON-LISP:T)))
                                (ARG4
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG5 (COMMON-LISP:* SB-ALIEN:LONG))
                                (ARG6
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG7 SB-ALIEN:LONG)
                                (ARG8
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_chk_free|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_chk_free" |R_chk_free|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_size_t| SB-ALIEN:UNSIGNED-LONG)
  (SB-ALIEN:DEFINE-ALIEN-TYPE |size_t| SB-ALIEN:UNSIGNED-LONG))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_chk_realloc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_chk_realloc" |R_chk_realloc|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_chk_calloc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_chk_calloc" |R_chk_calloc|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 SB-ALIEN:UNSIGNED-LONG)
                                (ARG2 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_ssize_t| SB-ALIEN:LONG)
  (SB-ALIEN:DEFINE-ALIEN-TYPE |ssize_t| SB-ALIEN:LONG))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |swab|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("swab" |swab|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG3 SB-ALIEN:LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strsignal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strsignal" |strsignal|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (|sig| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strsep|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strsep" |strsep|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strncasecmp|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strncasecmp" |strncasecmp|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strmode|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strmode" |strmode|)
                                SB-ALIEN:VOID
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strlcpy|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strlcpy" |strlcpy|)
                                SB-ALIEN:UNSIGNED-LONG
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strlcat|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strlcat" |strlcat|)
                                SB-ALIEN:UNSIGNED-LONG
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strcasecmp|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strcasecmp" |strcasecmp|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |bcopy|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("bcopy" |bcopy|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strdup|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strdup" |strdup|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strtok_r|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strtok_r" |strtok_r|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |memccpy|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("memccpy" |memccpy|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG3 SB-ALIEN:INT)
                                (ARG4 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strxfrm|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strxfrm" |strxfrm|)
                                SB-ALIEN:UNSIGNED-LONG
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strtok|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strtok" |strtok|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strnstr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strnstr" |strnstr|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strerror_r|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strerror_r" |strerror_r|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strerror|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strerror" |strerror|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strcoll|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strcoll" |strcoll|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strcasestr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strcasestr" |strcasestr|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |stpcpy|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("stpcpy" |stpcpy|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |memmove|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("memmove" |memmove|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |memchr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("memchr" |memchr|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_max_col|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_max_col" |R_max_col|)
                                SB-ALIEN:VOID
                                (|matrix| (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (|nr| (COMMON-LISP:* SB-ALIEN:INT))
                                (|nc| (COMMON-LISP:* SB-ALIEN:INT))
                                (|maxes| (COMMON-LISP:* SB-ALIEN:INT))
                                (|ties_meth| (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |find_interv_vec|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("find_interv_vec" |find_interv_vec|)
                                SB-ALIEN:VOID
                                (|xt| (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (|n| (COMMON-LISP:* SB-ALIEN:INT))
                                (|x| (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (|nx| (COMMON-LISP:* SB-ALIEN:INT))
                                (|rightmost_closed|
                                 (COMMON-LISP:* SB-ALIEN:INT))
                                (|all_inside| (COMMON-LISP:* SB-ALIEN:INT))
                                (|indx| (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |findInterval|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("findInterval" |findInterval|)
                                SB-ALIEN:INT
                                (|xt| (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (|n| SB-ALIEN:INT)
                                (|x| SB-ALIEN:DOUBLE)
                                (|rightmost_closed| |Rboolean|)
                                (|all_inside| |Rboolean|)
                                (|ilo| SB-ALIEN:INT)
                                (|mflag| (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_CheckStack|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_CheckStack" |R_CheckStack|) SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_CheckUserInterrupt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_CheckUserInterrupt" |R_CheckUserInterrupt|)
                                SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_rgb2hsv|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_rgb2hsv" |Rf_rgb2hsv|)
                                SB-ALIEN:VOID
                                (|r| SB-ALIEN:DOUBLE)
                                (|g| SB-ALIEN:DOUBLE)
                                (|b| SB-ALIEN:DOUBLE)
                                (|h| (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (|s| (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (|v| (COMMON-LISP:* SB-ALIEN:DOUBLE)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_hsv2rgb|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_hsv2rgb" |Rf_hsv2rgb|)
                                SB-ALIEN:VOID
                                (|h| SB-ALIEN:DOUBLE)
                                (|s| SB-ALIEN:DOUBLE)
                                (|v| SB-ALIEN:DOUBLE)
                                (|r| (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (|g| (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (|b| (COMMON-LISP:* SB-ALIEN:DOUBLE)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_tmpnam|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_tmpnam" |R_tmpnam|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (|prefix| (COMMON-LISP:* COMMON-LISP:CHAR))
                                (|tempdir| (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_strtod|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_strtod" |R_strtod|)
                                SB-ALIEN:DOUBLE
                                (|c| (COMMON-LISP:* COMMON-LISP:CHAR))
                                (|end|
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_isBlankString|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_isBlankString" |Rf_isBlankString|)
                                |Rboolean|
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_StringTrue|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_StringTrue" |Rf_StringTrue|)
                                |Rboolean|
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_StringFalse|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_StringFalse" |Rf_StringFalse|)
                                |Rboolean|
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_setRVector|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_setRVector" |Rf_setRVector|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_setIVector|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_setIVector" |Rf_setIVector|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_ExpandFileName|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_ExpandFileName" |R_ExpandFileName|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_IndexWidth|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_IndexWidth" |Rf_IndexWidth|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_qsort_int_I|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_qsort_int_I" |R_qsort_int_I|)
                                SB-ALIEN:VOID
                                (|iv| (COMMON-LISP:* SB-ALIEN:INT))
                                (I (COMMON-LISP:* SB-ALIEN:INT))
                                (|i| SB-ALIEN:INT)
                                (|j| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_qsort_int|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_qsort_int" |R_qsort_int|)
                                SB-ALIEN:VOID
                                (|iv| (COMMON-LISP:* SB-ALIEN:INT))
                                (|i| SB-ALIEN:INT)
                                (|j| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_qsort_I|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_qsort_I" |R_qsort_I|)
                                SB-ALIEN:VOID
                                (|v| (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (I (COMMON-LISP:* SB-ALIEN:INT))
                                (|i| SB-ALIEN:INT)
                                (|j| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_qsort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_qsort" |R_qsort|)
                                SB-ALIEN:VOID
                                (|v| (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (|i| SB-ALIEN:INT)
                                (|j| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_cPsort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_cPsort" |Rf_cPsort|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |Rcomplex|)))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_rPsort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_rPsort" |Rf_rPsort|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_iPsort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_iPsort" |Rf_iPsort|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_revsort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_revsort" |Rf_revsort|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |rsort_with_index|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("rsort_with_index" |rsort_with_index|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_csort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_csort" |R_csort|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |Rcomplex|)))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_rsort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_rsort" |R_rsort|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_isort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_isort" |R_isort|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |user_norm_rand|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("user_norm_rand" |user_norm_rand|)
                                (COMMON-LISP:* SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |user_unif_seedloc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("user_unif_seedloc" |user_unif_seedloc|)
                                (COMMON-LISP:* SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |user_unif_nseed|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("user_unif_nseed" |user_unif_nseed|)
                                (COMMON-LISP:* SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |Int32| SB-ALIEN:UNSIGNED-INT)
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |user_unif_init|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("user_unif_init" |user_unif_init|)
                                SB-ALIEN:VOID
                                (ARG1 SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |user_unif_rand|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("user_unif_rand" |user_unif_rand|)
                                (COMMON-LISP:* SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |exp_rand|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("exp_rand" |exp_rand|) SB-ALIEN:DOUBLE)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |norm_rand|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("norm_rand" |norm_rand|) SB-ALIEN:DOUBLE)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |unif_rand|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("unif_rand" |unif_rand|) SB-ALIEN:DOUBLE)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |PutRNGstate|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("PutRNGstate" |PutRNGstate|) SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |GetRNGstate|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("GetRNGstate" |GetRNGstate|) SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |N01type|
                             (SB-ALIEN:ENUM COMMON-LISP:NIL
                                            (BUGGY_KINDERMAN_RAMAGE 0)
                                            (AHRENS_DIETER 1)
                                            (BOX_MULLER 2)
                                            (USER_NORM 3)
                                            (INVERSION 4)
                                            (KINDERMAN_RAMAGE 5)))
 (COMMON-LISP:DEFPARAMETER BUGGY_KINDERMAN_RAMAGE 0)
 (COMMON-LISP:DEFPARAMETER AHRENS_DIETER 1)
 (COMMON-LISP:DEFPARAMETER BOX_MULLER 2)
 (COMMON-LISP:DEFPARAMETER USER_NORM 3)
 (COMMON-LISP:DEFPARAMETER INVERSION 4)
 (COMMON-LISP:DEFPARAMETER KINDERMAN_RAMAGE 5)) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |RNGtype|
                             (SB-ALIEN:ENUM COMMON-LISP:NIL
                                            (WICHMANN_HILL 0)
                                            (MARSAGLIA_MULTICARRY 1)
                                            (SUPER_DUPER 2)
                                            (MERSENNE_TWISTER 3)
                                            (KNUTH_TAOCP 4)
                                            (USER_UNIF 5)
                                            (KNUTH_TAOCP2 6)))
 (COMMON-LISP:DEFPARAMETER WICHMANN_HILL 0)
 (COMMON-LISP:DEFPARAMETER MARSAGLIA_MULTICARRY 1)
 (COMMON-LISP:DEFPARAMETER SUPER_DUPER 2)
 (COMMON-LISP:DEFPARAMETER MERSENNE_TWISTER 3)
 (COMMON-LISP:DEFPARAMETER KNUTH_TAOCP 4)
 (COMMON-LISP:DEFPARAMETER USER_UNIF 5)
 (COMMON-LISP:DEFPARAMETER KNUTH_TAOCP2 6)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_va_list|
                              (COMMON-LISP:* COMMON-LISP:CHAR))
  (SB-ALIEN:DEFINE-ALIEN-TYPE |va_list| (COMMON-LISP:* COMMON-LISP:CHAR)))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |REvprintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("REvprintf" |REvprintf|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rvprintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rvprintf" |Rvprintf|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |REprintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("REprintf" |REprintf|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rprintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rprintf" |Rprintf|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__gnuc_va_list| (COMMON-LISP:* COMMON-LISP:CHAR)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |S_realloc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("S_realloc" |S_realloc|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 SB-ALIEN:LONG)
                                (ARG3 SB-ALIEN:LONG)
                                (ARG4 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |S_alloc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("S_alloc" |S_alloc|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:LONG)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_alloc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_alloc" |R_alloc|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:LONG)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_gc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_gc" |R_gc|) SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |vmaxset|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("vmaxset" |vmaxset|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |vmaxget|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("vmaxget" |vmaxget|)
                                (COMMON-LISP:* COMMON-LISP:CHAR))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_ShowMessage|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_ShowMessage" |R_ShowMessage|)
                                SB-ALIEN:VOID
                                (|s| (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE UNIMPLEMENTED))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("UNIMPLEMENTED" UNIMPLEMENTED)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |WrongArgCount|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("WrongArgCount" |WrongArgCount|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_warning|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_warning" |Rf_warning|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |Rf_error|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("Rf_error" |Rf_error|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_isnancpp|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_isnancpp" |R_isnancpp|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_finite|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_finite" |R_finite|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_IsNaN|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_IsNaN" |R_IsNaN|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |R_IsNA|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("R_IsNA" |R_IsNA|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_NaInt" |R_NaInt|) SB-ALIEN:INT) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_NaReal" |R_NaReal|) SB-ALIEN:DOUBLE) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_NegInf" |R_NegInf|) SB-ALIEN:DOUBLE) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_PosInf" |R_PosInf|) SB-ALIEN:DOUBLE) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("R_NaN" |R_NaN|) SB-ALIEN:DOUBLE) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |drem|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("drem" |drem|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |significand|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("significand" |significand|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |gamma|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("gamma" |gamma|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |finite|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("finite" |finite|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |roundtol|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("roundtol" |roundtol|)
                                SB-ALIEN:LONG
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |rinttol|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("rinttol" |rinttol|)
                                SB-ALIEN:LONG
                                (ARG1 SB-ALIEN:DOUBLE))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("signgam" |signgam|) SB-ALIEN:INT) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |scalb|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("scalb" |scalb|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |yn|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("yn" |yn|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |y1|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("y1" |y1|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |y0|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("y0" |y0|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |jn|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("jn" |jn|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |j1|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("j1" |j1|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |j0|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("j0" |j0|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__nan|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__nan" |__nan|) COMMON-LISP:FLOAT)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__infl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__infl" |__infl|) SB-ALIEN:DOUBLE)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__inff|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__inff" |__inff|) COMMON-LISP:FLOAT)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__inf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__inf" |__inf|) SB-ALIEN:DOUBLE)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fmal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fmal" |fmal|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE)
                                (ARG3 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fminl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fminl" |fminl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fmaxl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fmaxl" |fmaxl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fdiml|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fdiml" |fdiml|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |nexttowardl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("nexttowardl" |nexttowardl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |nexttowardf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("nexttowardf" |nexttowardf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |nexttoward|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("nexttoward" |nexttoward|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |nextafterl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("nextafterl" |nextafterl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |copysignl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("copysignl" |copysignl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |remquol|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("remquol" |remquol|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE)
                                (ARG3 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |remainderl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("remainderl" |remainderl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fmodl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fmodl" |fmodl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |truncl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("truncl" |truncl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |llroundl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("llroundl" |llroundl|)
                                (COMMON-LISP:INTEGER 64)
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |lroundl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("lroundl" |lroundl|)
                                SB-ALIEN:LONG
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |roundl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("roundl" |roundl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |llrintl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("llrintl" |llrintl|)
                                (COMMON-LISP:INTEGER 64)
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |lrintl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("lrintl" |lrintl|)
                                SB-ALIEN:LONG
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |rintl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("rintl" |rintl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |nearbyintl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("nearbyintl" |nearbyintl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |floorl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("floorl" |floorl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ceill|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ceill" |ceill|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |tgammal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("tgammal" |tgammal|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |lgammal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("lgammal" |lgammal|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |erfcl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("erfcl" |erfcl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |erfl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("erfl" |erfl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |powl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("powl" |powl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |hypotl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("hypotl" |hypotl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cbrtl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cbrtl" |cbrtl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |scalblnl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("scalblnl" |scalblnl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |scalbnl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("scalbnl" |scalbnl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ilogbl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ilogbl" |ilogbl|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |frexpl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("frexpl" |frexpl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ldexpl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ldexpl" |ldexpl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |modfl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("modfl" |modfl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:DOUBLE)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |logbl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("logbl" |logbl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |log1pl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("log1pl" |log1pl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |log2l|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("log2l" |log2l|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |log10l|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("log10l" |log10l|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |expm1l|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("expm1l" |expm1l|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |exp2l|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("exp2l" |exp2l|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |tanhl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("tanhl" |tanhl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |sinhl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("sinhl" |sinhl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |coshl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("coshl" |coshl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atanhl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atanhl" |atanhl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |asinhl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("asinhl" |asinhl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |acoshl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("acoshl" |acoshl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |tanl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("tanl" |tanl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atan2l|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atan2l" |atan2l|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atanl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atanl" |atanl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |asinl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("asinl" |asinl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |acosl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("acosl" |acosl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fmaf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fmaf" |fmaf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 COMMON-LISP:FLOAT)
                                (ARG3 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fma|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fma" |fma|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE)
                                (ARG3 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fminf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fminf" |fminf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fmin|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fmin" |fmin|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fmaxf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fmaxf" |fmaxf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fmax|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fmax" |fmax|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fdimf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fdimf" |fdimf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fdim|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fdim" |fdim|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |nextafterf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("nextafterf" |nextafterf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |nextafter|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("nextafter" |nextafter|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |copysignf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("copysignf" |copysignf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |copysign|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("copysign" |copysign|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |remquof|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("remquof" |remquof|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 COMMON-LISP:FLOAT)
                                (ARG3 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |remquo|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("remquo" |remquo|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE)
                                (ARG3 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |remainderf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("remainderf" |remainderf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |remainder|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("remainder" |remainder|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fmodf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fmodf" |fmodf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fmod|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fmod" |fmod|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |truncf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("truncf" |truncf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |trunc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("trunc" |trunc|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |llroundf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("llroundf" |llroundf|)
                                (COMMON-LISP:INTEGER 64)
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |llround|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("llround" |llround|)
                                (COMMON-LISP:INTEGER 64)
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |lroundf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("lroundf" |lroundf|)
                                SB-ALIEN:LONG
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |lround|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("lround" |lround|)
                                SB-ALIEN:LONG
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |roundf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("roundf" |roundf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |round|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("round" |round|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |llrintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("llrintf" |llrintf|)
                                (COMMON-LISP:INTEGER 64)
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |llrint|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("llrint" |llrint|)
                                (COMMON-LISP:INTEGER 64)
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |lrintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("lrintf" |lrintf|)
                                SB-ALIEN:LONG
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |lrint|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("lrint" |lrint|)
                                SB-ALIEN:LONG
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |rintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("rintf" |rintf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |rint|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("rint" |rint|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |nearbyintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("nearbyintf" |nearbyintf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |nearbyint|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("nearbyint" |nearbyint|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |floorf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("floorf" |floorf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |floor|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("floor" |floor|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ceilf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ceilf" |ceilf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ceil|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ceil" |ceil|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |tgammaf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("tgammaf" |tgammaf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |tgamma|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("tgamma" |tgamma|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |lgammaf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("lgammaf" |lgammaf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |lgamma|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("lgamma" |lgamma|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |erfcf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("erfcf" |erfcf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |erfc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("erfc" |erfc|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |erff|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("erff" |erff|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |erf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("erf" |erf|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |powf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("powf" |powf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |pow|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("pow" |pow|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |hypotf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("hypotf" |hypotf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |hypot|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("hypot" |hypot|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cbrtf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cbrtf" |cbrtf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cbrt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cbrt" |cbrt|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |scalblnf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("scalblnf" |scalblnf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 SB-ALIEN:LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |scalbln|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("scalbln" |scalbln|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |scalbnf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("scalbnf" |scalbnf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |scalbn|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("scalbn" |scalbn|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ilogbf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ilogbf" |ilogbf|)
                                SB-ALIEN:INT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ilogb|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ilogb" |ilogb|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |frexpf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("frexpf" |frexpf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |frexp|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("frexp" |frexp|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ldexpf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ldexpf" |ldexpf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ldexp|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ldexp" |ldexp|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |modff|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("modff" |modff|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 (COMMON-LISP:* COMMON-LISP:FLOAT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |modf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("modf" |modf|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:DOUBLE)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |logbf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("logbf" |logbf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |logb|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("logb" |logb|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |log1pf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("log1pf" |log1pf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |log1p|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("log1p" |log1p|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |log2f|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("log2f" |log2f|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |log2|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("log2" |log2|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |log10f|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("log10f" |log10f|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |log10|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("log10" |log10|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |expm1f|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("expm1f" |expm1f|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |expm1|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("expm1" |expm1|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |exp2f|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("exp2f" |exp2f|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |exp2|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("exp2" |exp2|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |tanhf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("tanhf" |tanhf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |tanh|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("tanh" |tanh|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |sinhf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("sinhf" |sinhf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |sinh|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("sinh" |sinh|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |coshf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("coshf" |coshf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cosh|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cosh" |cosh|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atanhf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atanhf" |atanhf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atanh|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atanh" |atanh|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |asinhf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("asinhf" |asinhf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |asinh|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("asinh" |asinh|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |acoshf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("acoshf" |acoshf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |acosh|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("acosh" |acosh|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |tanf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("tanf" |tanf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |tan|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("tan" |tan|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atan2f|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atan2f" |atan2f|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT)
                                (ARG2 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atan2|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atan2" |atan2|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atanf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atanf" |atanf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atan|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atan" |atan|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |asinf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("asinf" |asinf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |asin|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("asin" |asin|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |acosf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("acosf" |acosf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |acos|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("acos" |acos|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__signbitl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__signbitl" |__signbitl|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__signbitd|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__signbitd" |__signbitd|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__signbitf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__signbitf" |__signbitf|)
                                SB-ALIEN:INT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__isnan|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__isnan" |__isnan|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__isnand|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__isnand" |__isnand|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__isnanf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__isnanf" |__isnanf|)
                                SB-ALIEN:INT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__isinf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__isinf" |__isinf|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__isinfd|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__isinfd" |__isinfd|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__isinff|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__isinff" |__isinff|)
                                SB-ALIEN:INT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__isfinite|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__isfinite" |__isfinite|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__isfinited|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__isfinited" |__isfinited|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__isfinitef|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__isfinitef" |__isfinitef|)
                                SB-ALIEN:INT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__isnormal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__isnormal" |__isnormal|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__isnormald|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__isnormald" |__isnormald|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__isnormalf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__isnormalf" |__isnormalf|)
                                SB-ALIEN:INT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__fpclassify|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__fpclassify" |__fpclassify|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__fpclassifyd|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__fpclassifyd" |__fpclassifyd|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__fpclassifyf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__fpclassifyf" |__fpclassifyf|)
                                SB-ALIEN:INT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__math_errhandling|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__math_errhandling" |__math_errhandling|)
                                SB-ALIEN:UNSIGNED-INT)) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE $_9
                             (SB-ALIEN:ENUM COMMON-LISP:NIL
                                            (_FP_NAN 1)
                                            (_FP_INFINITE 2)
                                            (_FP_ZERO 3)
                                            (_FP_NORMAL 4)
                                            (_FP_SUBNORMAL 5)
                                            (_FP_SUPERNORMAL 6)))
 (COMMON-LISP:DEFPARAMETER _FP_NAN 1)
 (COMMON-LISP:DEFPARAMETER _FP_INFINITE 2)
 (COMMON-LISP:DEFPARAMETER _FP_ZERO 3)
 (COMMON-LISP:DEFPARAMETER _FP_NORMAL 4)
 (COMMON-LISP:DEFPARAMETER _FP_SUBNORMAL 5)
 (COMMON-LISP:DEFPARAMETER _FP_SUPERNORMAL 6)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |double_t| SB-ALIEN:DOUBLE) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |float_t| COMMON-LISP:FLOAT) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |valloc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("valloc" |valloc|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 SB-ALIEN:UNSIGNED-LONG))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("suboptarg" |suboptarg|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strtouq|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strtouq" |strtouq|)
                                (COMMON-LISP:INTEGER 64)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strtoq|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strtoq" |strtoq|)
                                (COMMON-LISP:INTEGER 64)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |reallocf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("reallocf" |reallocf|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |rand_r|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("rand_r" |rand_r|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* SB-ALIEN:UNSIGNED-INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |srandomdev|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("srandomdev" |srandomdev|) SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |sranddev|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("sranddev" |sranddev|) SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |sradixsort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("sradixsort" |sradixsort|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* SB-ALIEN:UNSIGNED-CHAR)))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 (COMMON-LISP:* SB-ALIEN:UNSIGNED-CHAR))
                                (ARG4 SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |setprogname|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("setprogname" |setprogname|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |radixsort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("radixsort" |radixsort|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* SB-ALIEN:UNSIGNED-CHAR)))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 (COMMON-LISP:* SB-ALIEN:UNSIGNED-CHAR))
                                (ARG4 SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |qsort_r|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("qsort_r" |qsort_r|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 SB-ALIEN:UNSIGNED-LONG)
                                (ARG3 SB-ALIEN:UNSIGNED-LONG)
                                (ARG4 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG5
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:INT
                                   (COMMON-LISP:* COMMON-LISP:T)
                                   (COMMON-LISP:* COMMON-LISP:T)
                                   (COMMON-LISP:* COMMON-LISP:T)))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |mergesort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("mergesort" |mergesort|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 SB-ALIEN:UNSIGNED-LONG)
                                (ARG3 SB-ALIEN:UNSIGNED-LONG)
                                (ARG4
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:INT
                                   (COMMON-LISP:* COMMON-LISP:T)
                                   (COMMON-LISP:* COMMON-LISP:T)))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |heapsort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("heapsort" |heapsort|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 SB-ALIEN:UNSIGNED-LONG)
                                (ARG3 SB-ALIEN:UNSIGNED-LONG)
                                (ARG4
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:INT
                                   (COMMON-LISP:* COMMON-LISP:T)
                                   (COMMON-LISP:* COMMON-LISP:T)))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |getprogname|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("getprogname" |getprogname|)
                                (COMMON-LISP:* COMMON-LISP:CHAR))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |getloadavg|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("getloadavg" |getloadavg|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* SB-ALIEN:DOUBLE))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |getbsize|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("getbsize" |getbsize|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG2 (COMMON-LISP:* SB-ALIEN:LONG)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (COMMON-LISP:PROGN
   (SB-ALIEN:DEFINE-ALIEN-TYPE |__int32_t| SB-ALIEN:INT)
   (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_dev_t| SB-ALIEN:INT))
  (SB-ALIEN:DEFINE-ALIEN-TYPE |dev_t| SB-ALIEN:INT))
 (COMMON-LISP:PROGN
  (COMMON-LISP:PROGN
   (SB-ALIEN:DEFINE-ALIEN-TYPE |__uint16_t| SB-ALIEN:UNSIGNED-SHORT)
   (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_mode_t| SB-ALIEN:UNSIGNED-SHORT))
  (SB-ALIEN:DEFINE-ALIEN-TYPE |mode_t| SB-ALIEN:UNSIGNED-SHORT))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |devname_r|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("devname_r" |devname_r|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 SB-ALIEN:UNSIGNED-SHORT)
                                (|buf| (COMMON-LISP:* COMMON-LISP:CHAR))
                                (|len| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |devname|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("devname" |devname|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 SB-ALIEN:UNSIGNED-SHORT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |daemon|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("daemon" |daemon|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cgetustr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cgetustr" |cgetustr|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cgetstr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cgetstr" |cgetstr|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cgetset|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cgetset" |cgetset|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cgetnum|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cgetnum" |cgetnum|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 (COMMON-LISP:* SB-ALIEN:LONG)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cgetnext|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cgetnext" |cgetnext|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cgetmatch|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cgetmatch" |cgetmatch|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cgetfirst|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cgetfirst" |cgetfirst|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cgetent|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cgetent" |cgetent|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG3 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cgetclose|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cgetclose" |cgetclose|) SB-ALIEN:INT)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cgetcap|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cgetcap" |cgetcap|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |arc4random_stir|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("arc4random_stir" |arc4random_stir|)
                                SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |arc4random_addrandom|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("arc4random_addrandom" |arc4random_addrandom|)
                                SB-ALIEN:VOID
                                (|dat| (COMMON-LISP:* SB-ALIEN:UNSIGNED-CHAR))
                                (|datlen| SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |u_int32_t| SB-ALIEN:UNSIGNED-INT)
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |arc4random|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("arc4random" |arc4random|)
                                SB-ALIEN:UNSIGNED-INT)) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |u_int64_t| (COMMON-LISP:INTEGER 64))
 (SB-ALIEN:DEFINE-ALIEN-TYPE |syscall_arg_t| (COMMON-LISP:INTEGER 64))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |int64_t| (COMMON-LISP:INTEGER 64))
 (SB-ALIEN:DEFINE-ALIEN-TYPE |user_time_t| (COMMON-LISP:INTEGER 64))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |user_ulong_t| (COMMON-LISP:INTEGER 64)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |user_long_t| (COMMON-LISP:INTEGER 64)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |user_ssize_t| (COMMON-LISP:INTEGER 64)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |user_size_t| (COMMON-LISP:INTEGER 64)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |user_addr_t| (COMMON-LISP:INTEGER 64)) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |int32_t| SB-ALIEN:INT)
 (SB-ALIEN:DEFINE-ALIEN-TYPE |register_t| SB-ALIEN:INT)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |u_int16_t| SB-ALIEN:UNSIGNED-SHORT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |u_int8_t| SB-ALIEN:UNSIGNED-CHAR) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |unsetenv|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("unsetenv" |unsetenv|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |unlockpt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("unlockpt" |unlockpt|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |srandom|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("srandom" |srandom|)
                                SB-ALIEN:VOID
                                (ARG1 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |srand48|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("srand48" |srand48|)
                                SB-ALIEN:VOID
                                (ARG1 SB-ALIEN:LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |setstate|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("setstate" |setstate|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |setkey|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("setkey" |setkey|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |setenv|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("setenv" |setenv|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |seed48|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("seed48" |seed48|)
                                (COMMON-LISP:* SB-ALIEN:UNSIGNED-SHORT)
                                (ARG1 (COMMON-LISP:* SB-ALIEN:UNSIGNED-SHORT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |realpath|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("realpath" |realpath|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (|resolved_path|
                                 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |random|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("random" |random|) SB-ALIEN:LONG)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |putenv|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("putenv" |putenv|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ptsname|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ptsname" |ptsname|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |posix_openpt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("posix_openpt" |posix_openpt|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |nrand48|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("nrand48" |nrand48|)
                                SB-ALIEN:LONG
                                (ARG1 (COMMON-LISP:* SB-ALIEN:UNSIGNED-SHORT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |mrand48|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("mrand48" |mrand48|) SB-ALIEN:LONG)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |mkstemp|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("mkstemp" |mkstemp|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |mktemp|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("mktemp" |mktemp|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |lrand48|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("lrand48" |lrand48|) SB-ALIEN:LONG)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |lcong48|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("lcong48" |lcong48|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* SB-ALIEN:UNSIGNED-SHORT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |l64a|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("l64a" |l64a|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |jrand48|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("jrand48" |jrand48|)
                                SB-ALIEN:LONG
                                (ARG1 (COMMON-LISP:* SB-ALIEN:UNSIGNED-SHORT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |initstate|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("initstate" |initstate|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:UNSIGNED-LONG)
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |grantpt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("grantpt" |grantpt|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |getsubopt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("getsubopt" |getsubopt|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG3
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |gcvt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("gcvt" |gcvt|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fcvt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fcvt" |fcvt|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG4 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |erand48|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("erand48" |erand48|)
                                SB-ALIEN:DOUBLE
                                (ARG1 (COMMON-LISP:* SB-ALIEN:UNSIGNED-SHORT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ecvt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ecvt" |ecvt|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 SB-ALIEN:DOUBLE)
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG4 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |drand48|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("drand48" |drand48|) SB-ALIEN:DOUBLE)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |a64l|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("a64l" |a64l|)
                                SB-ALIEN:LONG
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |wctomb|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("wctomb" |wctomb|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |wcstombs|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("wcstombs" |wcstombs|)
                                SB-ALIEN:UNSIGNED-LONG
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |system|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("system" |system|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strtoull|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strtoull" |strtoull|)
                                (COMMON-LISP:INTEGER 64)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strtoul|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strtoul" |strtoul|)
                                SB-ALIEN:UNSIGNED-LONG
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strtoll|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strtoll" |strtoll|)
                                (COMMON-LISP:INTEGER 64)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strtold|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strtold" |strtold|)
                                SB-ALIEN:DOUBLE
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strtol|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strtol" |strtol|)
                                SB-ALIEN:LONG
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strtof|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strtof" |strtof|)
                                COMMON-LISP:FLOAT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strtod|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strtod" |strtod|)
                                SB-ALIEN:DOUBLE
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |srand|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("srand" |srand|)
                                SB-ALIEN:VOID
                                (ARG1 SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |realloc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("realloc" |realloc|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |rand|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("rand" |rand|) SB-ALIEN:INT)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |qsort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("qsort" |qsort|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 SB-ALIEN:UNSIGNED-LONG)
                                (ARG3 SB-ALIEN:UNSIGNED-LONG)
                                (ARG4
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:INT
                                   (COMMON-LISP:* COMMON-LISP:T)
                                   (COMMON-LISP:* COMMON-LISP:T)))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |mbtowc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("mbtowc" |mbtowc|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |mbstowcs|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("mbstowcs" |mbstowcs|)
                                SB-ALIEN:UNSIGNED-LONG
                                (ARG1 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |mblen|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("mblen" |mblen|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |malloc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("malloc" |malloc|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |lldiv_t|
                             (SB-ALIEN:STRUCT |lldiv_t|
                                              (|quot| (COMMON-LISP:INTEGER 64)
                                                      :ALIGNMENT
                                                      8)
                                              (|rem| (COMMON-LISP:INTEGER 64)
                                                     :ALIGNMENT
                                                     64)))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |lldiv|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("lldiv" |lldiv|)
                                (SB-ALIEN:STRUCT |lldiv_t|)
                                (ARG1 (COMMON-LISP:INTEGER 64))
                                (ARG2 (COMMON-LISP:INTEGER 64)))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |ldiv_t|
                             (SB-ALIEN:STRUCT |ldiv_t|
                                              (|quot| SB-ALIEN:LONG
                                                      :ALIGNMENT
                                                      8)
                                              (|rem| SB-ALIEN:LONG
                                                     :ALIGNMENT
                                                     32)))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ldiv|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ldiv" |ldiv|)
                                (SB-ALIEN:STRUCT |ldiv_t|)
                                (ARG1 SB-ALIEN:LONG)
                                (ARG2 SB-ALIEN:LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |getenv|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("getenv" |getenv|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |free|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("free" |free|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T)))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |div_t|
                             (SB-ALIEN:STRUCT |div_t|
                                              (|quot| SB-ALIEN:INT
                                                      :ALIGNMENT
                                                      8)
                                              (|rem| SB-ALIEN:INT
                                                     :ALIGNMENT
                                                     32)))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |div|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("div" |div|)
                                (SB-ALIEN:STRUCT |div_t|)
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |calloc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("calloc" |calloc|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 SB-ALIEN:UNSIGNED-LONG)
                                (ARG2 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |bsearch|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("bsearch" |bsearch|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG)
                                (ARG4 SB-ALIEN:UNSIGNED-LONG)
                                (ARG5
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:INT
                                   (COMMON-LISP:* COMMON-LISP:T)
                                   (COMMON-LISP:* COMMON-LISP:T)))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atoll|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atoll" |atoll|)
                                (COMMON-LISP:INTEGER 64)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atol|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atol" |atol|)
                                SB-ALIEN:LONG
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atoi|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atoi" |atoi|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atof|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atof" |atof|)
                                SB-ALIEN:DOUBLE
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |atexit|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("atexit" |atexit|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* #'SB-ALIEN:VOID)))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("__mb_cur_max" |__mb_cur_max|) SB-ALIEN:INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |rune_t| SB-ALIEN:INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |ct_rune_t| SB-ALIEN:INT) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_pid_t| SB-ALIEN:INT)
  (SB-ALIEN:DEFINE-ALIEN-TYPE |pid_t| SB-ALIEN:INT))
 (COMMON-LISP:PROGN
  (COMMON-LISP:PROGN
   (COMMON-LISP:PROGN
    (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_time_t| SB-ALIEN:LONG)
    (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_suseconds_t| SB-ALIEN:INT)
    (SB-ALIEN:DEFINE-ALIEN-TYPE |timeval|
                                (SB-ALIEN:STRUCT |timeval|
                                                 (|tv_sec| SB-ALIEN:LONG
                                                           :ALIGNMENT
                                                           8)
                                                 (|tv_usec| SB-ALIEN:INT
                                                            :ALIGNMENT
                                                            32))))
   (SB-ALIEN:DEFINE-ALIEN-TYPE |rusage|
                               (SB-ALIEN:STRUCT |rusage|
                                                (|ru_utime|
                                                 (SB-ALIEN:STRUCT |timeval|)
                                                 :ALIGNMENT
                                                 8)
                                                (|ru_stime|
                                                 (SB-ALIEN:STRUCT |timeval|)
                                                 :ALIGNMENT
                                                 64)
                                                (|ru_maxrss| SB-ALIEN:LONG
                                                             :ALIGNMENT
                                                             64)
                                                (|ru_ixrss| SB-ALIEN:LONG
                                                            :ALIGNMENT
                                                            32)
                                                (|ru_idrss| SB-ALIEN:LONG
                                                            :ALIGNMENT
                                                            64)
                                                (|ru_isrss| SB-ALIEN:LONG
                                                            :ALIGNMENT
                                                            32)
                                                (|ru_minflt| SB-ALIEN:LONG
                                                             :ALIGNMENT
                                                             64)
                                                (|ru_majflt| SB-ALIEN:LONG
                                                             :ALIGNMENT
                                                             32)
                                                (|ru_nswap| SB-ALIEN:LONG
                                                            :ALIGNMENT
                                                            64)
                                                (|ru_inblock| SB-ALIEN:LONG
                                                              :ALIGNMENT
                                                              32)
                                                (|ru_oublock| SB-ALIEN:LONG
                                                              :ALIGNMENT
                                                              64)
                                                (|ru_msgsnd| SB-ALIEN:LONG
                                                             :ALIGNMENT
                                                             32)
                                                (|ru_msgrcv| SB-ALIEN:LONG
                                                             :ALIGNMENT
                                                             64)
                                                (|ru_nsignals| SB-ALIEN:LONG
                                                               :ALIGNMENT
                                                               32)
                                                (|ru_nvcsw| SB-ALIEN:LONG
                                                            :ALIGNMENT
                                                            64)
                                                (|ru_nivcsw| SB-ALIEN:LONG
                                                             :ALIGNMENT
                                                             32)))))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |wait4|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("wait4" |wait4|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG3 SB-ALIEN:INT)
                                (ARG4
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |rusage|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |wait3|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("wait3" |wait3|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |rusage|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (SB-ALIEN:DEFINE-ALIEN-TYPE |idtype_t|
                              (SB-ALIEN:ENUM COMMON-LISP:NIL
                                             (P_ALL 0)
                                             (P_PID 1)
                                             (P_PGID 2)))
  (COMMON-LISP:DEFPARAMETER P_ALL 0)
  (COMMON-LISP:DEFPARAMETER P_PID 1)
  (COMMON-LISP:DEFPARAMETER P_PGID 2))
 (COMMON-LISP:PROGN
  (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_id_t| SB-ALIEN:UNSIGNED-INT)
  (SB-ALIEN:DEFINE-ALIEN-TYPE |id_t| SB-ALIEN:UNSIGNED-INT))
 (COMMON-LISP:PROGN
  (COMMON-LISP:PROGN
   (COMMON-LISP:PROGN
    (COMMON-LISP:PROGN
     (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_uid_t| SB-ALIEN:UNSIGNED-INT)
     (SB-ALIEN:DEFINE-ALIEN-TYPE |uid_t| SB-ALIEN:UNSIGNED-INT))
    (SB-ALIEN:DEFINE-ALIEN-TYPE |sigval|
                                (COMMON-LISP:UNION |sigval|
                                                   (|sival_int| SB-ALIEN:INT)
                                                   (|sival_ptr|
                                                    (COMMON-LISP:*
                                                     COMMON-LISP:T))))
    (SB-ALIEN:DEFINE-ALIEN-TYPE |__siginfo|
                                (SB-ALIEN:STRUCT |__siginfo|
                                                 (|si_signo| SB-ALIEN:INT
                                                             :ALIGNMENT
                                                             8)
                                                 (|si_errno| SB-ALIEN:INT
                                                             :ALIGNMENT
                                                             32)
                                                 (|si_code| SB-ALIEN:INT
                                                            :ALIGNMENT
                                                            64)
                                                 (|si_pid| SB-ALIEN:INT
                                                           :ALIGNMENT
                                                           32)
                                                 (|si_uid|
                                                  SB-ALIEN:UNSIGNED-INT
                                                  :ALIGNMENT
                                                  64)
                                                 (|si_status| SB-ALIEN:INT
                                                              :ALIGNMENT
                                                              32)
                                                 (|si_addr|
                                                  (COMMON-LISP:* COMMON-LISP:T)
                                                  :ALIGNMENT
                                                  64)
                                                 (|si_value|
                                                  (COMMON-LISP:UNION |sigval|)
                                                  :ALIGNMENT
                                                  32)
                                                 (|si_band| SB-ALIEN:LONG
                                                            :ALIGNMENT
                                                            64)
                                                 (|pad|
                                                  (COMMON-LISP:ARRAY
                                                   SB-ALIEN:UNSIGNED-LONG
                                                   7)
                                                  :ALIGNMENT
                                                  32))))
   (SB-ALIEN:DEFINE-ALIEN-TYPE |siginfo_t| (SB-ALIEN:STRUCT |__siginfo|))))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |waitid|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("waitid" |waitid|)
                                SB-ALIEN:INT
                                (ARG1 |idtype_t|)
                                (ARG2 SB-ALIEN:UNSIGNED-INT)
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__siginfo|)))
                                (ARG4 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |waitpid|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("waitpid" |waitpid|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 (COMMON-LISP:* SB-ALIEN:INT))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |wait|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("wait" |wait|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* SB-ALIEN:INT)))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |N4wait3$_4E|
                             (SB-ALIEN:STRUCT |N4wait3$_4E|
                                              (|w_Termsig|
                                               SB-ALIEN:UNSIGNED-INT
                                               :ALIGNMENT
                                               8)
                                              (|w_Coredump|
                                               SB-ALIEN:UNSIGNED-INT
                                               :ALIGNMENT
                                               1)
                                              (|w_Retcode|
                                               SB-ALIEN:UNSIGNED-INT
                                               :ALIGNMENT
                                               8)
                                              (|w_Filler| SB-ALIEN:UNSIGNED-INT
                                                          :ALIGNMENT
                                                          16)))
 (SB-ALIEN:DEFINE-ALIEN-TYPE |N4wait3$_5E|
                             (SB-ALIEN:STRUCT |N4wait3$_5E|
                                              (|w_Stopval|
                                               SB-ALIEN:UNSIGNED-INT
                                               :ALIGNMENT
                                               8)
                                              (|w_Stopsig|
                                               SB-ALIEN:UNSIGNED-INT
                                               :ALIGNMENT
                                               8)
                                              (|w_Filler| SB-ALIEN:UNSIGNED-INT
                                                          :ALIGNMENT
                                                          16)))
 (SB-ALIEN:DEFINE-ALIEN-TYPE |wait|
                             (COMMON-LISP:UNION |wait|
                                                (|w_status| SB-ALIEN:INT)
                                                (|w_T|
                                                 (SB-ALIEN:STRUCT
                                                  |N4wait3$_4E|))
                                                (|w_S|
                                                 (SB-ALIEN:STRUCT
                                                  |N4wait3$_5E|))))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |uint32_t| SB-ALIEN:UNSIGNED-INT)
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |htonl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("htonl" |htonl|)
                                SB-ALIEN:UNSIGNED-INT
                                (ARG1 SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ntohl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ntohl" |ntohl|)
                                SB-ALIEN:UNSIGNED-INT
                                (ARG1 SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |uint16_t| SB-ALIEN:UNSIGNED-SHORT)
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |htons|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("htons" |htons|)
                                SB-ALIEN:UNSIGNED-SHORT
                                (ARG1 SB-ALIEN:UNSIGNED-SHORT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ntohs|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ntohs" |ntohs|)
                                SB-ALIEN:UNSIGNED-SHORT
                                (ARG1 SB-ALIEN:UNSIGNED-SHORT))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |uintptr_t| SB-ALIEN:UNSIGNED-LONG)
 (SB-ALIEN:DEFINE-ALIEN-TYPE |uint64_t| (COMMON-LISP:INTEGER 64))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |_OSWriteInt64|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("_OSWriteInt64" |_OSWriteInt64|)
                                SB-ALIEN:VOID
                                (|base| (COMMON-LISP:* COMMON-LISP:T))
                                (|byteOffset| SB-ALIEN:UNSIGNED-LONG)
                                (|data| (COMMON-LISP:INTEGER 64)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |_OSWriteInt32|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("_OSWriteInt32" |_OSWriteInt32|)
                                SB-ALIEN:VOID
                                (|base| (COMMON-LISP:* COMMON-LISP:T))
                                (|byteOffset| SB-ALIEN:UNSIGNED-LONG)
                                (|data| SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |_OSWriteInt16|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("_OSWriteInt16" |_OSWriteInt16|)
                                SB-ALIEN:VOID
                                (|base| (COMMON-LISP:* COMMON-LISP:T))
                                (|byteOffset| SB-ALIEN:UNSIGNED-LONG)
                                (|data| SB-ALIEN:UNSIGNED-SHORT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |_OSReadInt64|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("_OSReadInt64" |_OSReadInt64|)
                                (COMMON-LISP:INTEGER 64)
                                (|base| (COMMON-LISP:* COMMON-LISP:T))
                                (|byteOffset| SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |_OSReadInt32|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("_OSReadInt32" |_OSReadInt32|)
                                SB-ALIEN:UNSIGNED-INT
                                (|base| (COMMON-LISP:* COMMON-LISP:T))
                                (|byteOffset| SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |_OSReadInt16|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("_OSReadInt16" |_OSReadInt16|)
                                SB-ALIEN:UNSIGNED-SHORT
                                (|base| (COMMON-LISP:* COMMON-LISP:T))
                                (|byteOffset| SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |OSHostByteOrder|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("OSHostByteOrder" |OSHostByteOrder|)
                                SB-ALIEN:INT)) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE $_3
                             (SB-ALIEN:ENUM COMMON-LISP:NIL
                                            (|OSUnknownByteOrder| 0)
                                            (|OSLittleEndian| 1)
                                            (|OSBigEndian| 2)))
 (COMMON-LISP:DEFPARAMETER |OSUnknownByteOrder| 0)
 (COMMON-LISP:DEFPARAMETER |OSLittleEndian| 1)
 (COMMON-LISP:DEFPARAMETER |OSBigEndian| 2)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |OSWriteSwapInt64|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("OSWriteSwapInt64" |OSWriteSwapInt64|)
                                SB-ALIEN:VOID
                                (|base| (COMMON-LISP:* COMMON-LISP:T))
                                (|byteOffset| SB-ALIEN:UNSIGNED-LONG)
                                (|data| (COMMON-LISP:INTEGER 64)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |OSWriteSwapInt32|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("OSWriteSwapInt32" |OSWriteSwapInt32|)
                                SB-ALIEN:VOID
                                (|base| (COMMON-LISP:* COMMON-LISP:T))
                                (|byteOffset| SB-ALIEN:UNSIGNED-LONG)
                                (|data| SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |OSWriteSwapInt16|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("OSWriteSwapInt16" |OSWriteSwapInt16|)
                                SB-ALIEN:VOID
                                (|base| (COMMON-LISP:* COMMON-LISP:T))
                                (|byteOffset| SB-ALIEN:UNSIGNED-LONG)
                                (|data| SB-ALIEN:UNSIGNED-SHORT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |OSReadSwapInt64|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("OSReadSwapInt64" |OSReadSwapInt64|)
                                (COMMON-LISP:INTEGER 64)
                                (|base| (COMMON-LISP:* COMMON-LISP:T))
                                (|byteOffset| SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |OSReadSwapInt32|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("OSReadSwapInt32" |OSReadSwapInt32|)
                                SB-ALIEN:UNSIGNED-INT
                                (|base| (COMMON-LISP:* COMMON-LISP:T))
                                (|byteOffset| SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |OSReadSwapInt16|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("OSReadSwapInt16" |OSReadSwapInt16|)
                                SB-ALIEN:UNSIGNED-SHORT
                                (|base| (COMMON-LISP:* COMMON-LISP:T))
                                (|byteOffset| SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |_OSSwapInt64|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("_OSSwapInt64" |_OSSwapInt64|)
                                (COMMON-LISP:INTEGER 64)
                                (|data| (COMMON-LISP:INTEGER 64)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |_OSSwapInt32|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("_OSSwapInt32" |_OSSwapInt32|)
                                SB-ALIEN:UNSIGNED-INT
                                (|data| SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |_OSSwapInt16|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("_OSSwapInt16" |_OSSwapInt16|)
                                SB-ALIEN:UNSIGNED-SHORT
                                (|data| SB-ALIEN:UNSIGNED-SHORT))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |uintmax_t| (COMMON-LISP:INTEGER 64)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |intmax_t| (COMMON-LISP:INTEGER 64)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |intptr_t| SB-ALIEN:LONG) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |uint_fast64_t| (COMMON-LISP:INTEGER 64)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |uint_fast32_t| SB-ALIEN:UNSIGNED-INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |uint_fast16_t| SB-ALIEN:UNSIGNED-SHORT) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |uint8_t| SB-ALIEN:UNSIGNED-CHAR)
 (SB-ALIEN:DEFINE-ALIEN-TYPE |uint_fast8_t| SB-ALIEN:UNSIGNED-CHAR)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |int_fast64_t| (COMMON-LISP:INTEGER 64)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |int_fast32_t| SB-ALIEN:INT) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |int16_t| SB-ALIEN:SHORT)
 (SB-ALIEN:DEFINE-ALIEN-TYPE |int_fast16_t| SB-ALIEN:SHORT)) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |int8_t| COMMON-LISP:CHAR)
 (SB-ALIEN:DEFINE-ALIEN-TYPE |int_fast8_t| COMMON-LISP:CHAR)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |uint_least64_t| (COMMON-LISP:INTEGER 64)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |uint_least32_t| SB-ALIEN:UNSIGNED-INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |uint_least16_t| SB-ALIEN:UNSIGNED-SHORT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |uint_least8_t| SB-ALIEN:UNSIGNED-CHAR) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |int_least64_t| (COMMON-LISP:INTEGER 64)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |int_least32_t| SB-ALIEN:INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |int_least16_t| SB-ALIEN:SHORT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |int_least8_t| COMMON-LISP:CHAR) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (COMMON-LISP:PROGN
   (COMMON-LISP:PROGN
    (SB-ALIEN:DEFINE-ALIEN-TYPE |rlim_t| (COMMON-LISP:INTEGER 64))
    (SB-ALIEN:DEFINE-ALIEN-TYPE |rlimit|
                                (SB-ALIEN:STRUCT |rlimit|
                                                 (|rlim_cur|
                                                  (COMMON-LISP:INTEGER 64)
                                                  :ALIGNMENT
                                                  8)
                                                 (|rlim_max|
                                                  (COMMON-LISP:INTEGER 64)
                                                  :ALIGNMENT
                                                  64))))))
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |setrlimit|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("setrlimit" |setrlimit|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |rlimit|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |setpriority|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("setpriority" |setpriority|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 SB-ALIEN:UNSIGNED-INT)
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |getrusage|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("getrusage" |getrusage|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |rusage|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |getrlimit|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("getrlimit" |getrlimit|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |rlimit|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |getpriority|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("getpriority" |getpriority|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 SB-ALIEN:UNSIGNED-INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |signal|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("signal" |signal|)
                                (COMMON-LISP:*
                                 (COMMON-LISP:FUNCTION SB-ALIEN:VOID
                                  SB-ALIEN:INT))
                                (ARG1 SB-ALIEN:INT)
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:VOID
                                   SB-ALIEN:INT))))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |sigstack|
                            (SB-ALIEN:STRUCT |sigstack|
                                             (|ss_sp|
                                              (COMMON-LISP:* COMMON-LISP:CHAR)
                                              :ALIGNMENT
                                              8)
                                             (|ss_onstack| SB-ALIEN:INT
                                                           :ALIGNMENT
                                                           32))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |sigvec|
                            (SB-ALIEN:STRUCT |sigvec|
                                             (|sv_handler|
                                              (COMMON-LISP:*
                                               (COMMON-LISP:FUNCTION
                                                SB-ALIEN:VOID SB-ALIEN:INT))
                                              :ALIGNMENT
                                              8)
                                             (|sv_mask| SB-ALIEN:INT
                                                        :ALIGNMENT
                                                        32)
                                             (|sv_flags| SB-ALIEN:INT
                                                         :ALIGNMENT
                                                         64))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |sigaltstack|
                            (SB-ALIEN:STRUCT |sigaltstack|
                                             (|ss_sp|
                                              (COMMON-LISP:* COMMON-LISP:T)
                                              :ALIGNMENT
                                              8)
                                             (|ss_size| SB-ALIEN:UNSIGNED-LONG
                                                        :ALIGNMENT
                                                        32)
                                             (|ss_flags| SB-ALIEN:INT
                                                         :ALIGNMENT
                                                         64))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_stack_t|
                             (SB-ALIEN:STRUCT |sigaltstack|))
 (SB-ALIEN:DEFINE-ALIEN-TYPE |stack_t| (SB-ALIEN:STRUCT |sigaltstack|))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |sig_t|
                            (COMMON-LISP:*
                             (COMMON-LISP:FUNCTION SB-ALIEN:VOID SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |__sigaction_u|
                             (COMMON-LISP:UNION |__sigaction_u|
                                                (|__sa_handler|
                                                 (COMMON-LISP:*
                                                  (COMMON-LISP:FUNCTION
                                                   SB-ALIEN:VOID
                                                   SB-ALIEN:INT)))
                                                (|__sa_sigaction|
                                                 (COMMON-LISP:*
                                                  (COMMON-LISP:FUNCTION
                                                   SB-ALIEN:VOID SB-ALIEN:INT
                                                   (COMMON-LISP:*
                                                    (SB-ALIEN:STRUCT
                                                     |__siginfo|))
                                                   (COMMON-LISP:*
                                                    COMMON-LISP:T))))))
 (COMMON-LISP:PROGN
  (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_sigset_t| SB-ALIEN:UNSIGNED-INT)
  (SB-ALIEN:DEFINE-ALIEN-TYPE |sigset_t| SB-ALIEN:UNSIGNED-INT))
 (SB-ALIEN:DEFINE-ALIEN-TYPE |sigaction|
                             (SB-ALIEN:STRUCT |sigaction|
                                              (|__sigaction_u|
                                               (COMMON-LISP:UNION
                                                |__sigaction_u|)
                                               :ALIGNMENT
                                               8)
                                              (|sa_mask| SB-ALIEN:UNSIGNED-INT
                                                         :ALIGNMENT
                                                         32)
                                              (|sa_flags| SB-ALIEN:INT
                                                          :ALIGNMENT
                                                          64)))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__sigaction|
                            (SB-ALIEN:STRUCT |__sigaction|
                                             (|__sigaction_u|
                                              (COMMON-LISP:UNION
                                               |__sigaction_u|)
                                              :ALIGNMENT
                                              8)
                                             (|sa_tramp|
                                              (COMMON-LISP:*
                                               (COMMON-LISP:FUNCTION
                                                SB-ALIEN:VOID
                                                (COMMON-LISP:* COMMON-LISP:T)
                                                SB-ALIEN:INT SB-ALIEN:INT
                                                (COMMON-LISP:*
                                                 (SB-ALIEN:STRUCT |__siginfo|))
                                                (COMMON-LISP:* COMMON-LISP:T)))
                                              :ALIGNMENT
                                              32)
                                             (|sa_mask| SB-ALIEN:UNSIGNED-INT
                                                        :ALIGNMENT
                                                        64)
                                             (|sa_flags| SB-ALIEN:INT
                                                         :ALIGNMENT
                                                         32))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |sigevent|
                            (SB-ALIEN:STRUCT |sigevent|
                                             (|sigev_notify| SB-ALIEN:INT
                                                             :ALIGNMENT
                                                             8)
                                             (|sigev_signo| SB-ALIEN:INT
                                                            :ALIGNMENT
                                                            32)
                                             (|sigev_value|
                                              (COMMON-LISP:UNION |sigval|)
                                              :ALIGNMENT
                                              64)
                                             (|sigev_notify_function|
                                              (COMMON-LISP:*
                                               (COMMON-LISP:FUNCTION
                                                SB-ALIEN:VOID
                                                (COMMON-LISP:UNION |sigval|)))
                                              :ALIGNMENT
                                              32)
                                             (|sigev_notify_attributes|
                                              (COMMON-LISP:*
                                               (SB-ALIEN:STRUCT
                                                |_opaque_pthread_attr_t|))
                                              :ALIGNMENT
                                              64))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |ucontext64|
                            (SB-ALIEN:STRUCT |ucontext64|
                                             (|uc_onstack| SB-ALIEN:INT
                                                           :ALIGNMENT
                                                           8)
                                             (|uc_sigmask|
                                              SB-ALIEN:UNSIGNED-INT
                                              :ALIGNMENT
                                              32)
                                             (|uc_stack|
                                              (SB-ALIEN:STRUCT |sigaltstack|)
                                              :ALIGNMENT
                                              64)
                                             (|uc_link|
                                              (COMMON-LISP:*
                                               (SB-ALIEN:STRUCT |ucontext64|))
                                              :ALIGNMENT
                                              32)
                                             (|uc_mcsize|
                                              SB-ALIEN:UNSIGNED-LONG
                                              :ALIGNMENT
                                              64)
                                             (|uc_mcontext64|
                                              (COMMON-LISP:*
                                               (SB-ALIEN:STRUCT |mcontext64|))
                                              :ALIGNMENT
                                              32))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_ucontext64_t|
                             (SB-ALIEN:STRUCT |ucontext64|))
 (SB-ALIEN:DEFINE-ALIEN-TYPE |ucontext64_t| (SB-ALIEN:STRUCT |ucontext64|))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |ucontext|
                            (SB-ALIEN:STRUCT |ucontext|
                                             (|uc_onstack| SB-ALIEN:INT
                                                           :ALIGNMENT
                                                           8)
                                             (|uc_sigmask|
                                              SB-ALIEN:UNSIGNED-INT
                                              :ALIGNMENT
                                              32)
                                             (|uc_stack|
                                              (SB-ALIEN:STRUCT |sigaltstack|)
                                              :ALIGNMENT
                                              64)
                                             (|uc_link|
                                              (COMMON-LISP:*
                                               (SB-ALIEN:STRUCT |ucontext|))
                                              :ALIGNMENT
                                              32)
                                             (|uc_mcsize|
                                              SB-ALIEN:UNSIGNED-LONG
                                              :ALIGNMENT
                                              64)
                                             (|uc_mcontext|
                                              (COMMON-LISP:*
                                               (SB-ALIEN:STRUCT |mcontext|))
                                              :ALIGNMENT
                                              32))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_ucontext_t|
                             (SB-ALIEN:STRUCT |ucontext|))
 (SB-ALIEN:DEFINE-ALIEN-TYPE |ucontext_t| (SB-ALIEN:STRUCT |ucontext|))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |_opaque_pthread_attr_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_attr_t|
                                             (|__sig| SB-ALIEN:LONG
                                                      :ALIGNMENT
                                                      8)
                                             (|__opaque|
                                              (COMMON-LISP:ARRAY
                                               COMMON-LISP:CHAR
                                               36)
                                              :ALIGNMENT
                                              32))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_pthread_attr_t|
                             (SB-ALIEN:STRUCT |_opaque_pthread_attr_t|))
 (SB-ALIEN:DEFINE-ALIEN-TYPE |pthread_attr_t|
                             (SB-ALIEN:STRUCT |_opaque_pthread_attr_t|))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |mcontext64| (SB-ALIEN:STRUCT |mcontext64|))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_mcontext64_t|
                             (COMMON-LISP:* (SB-ALIEN:STRUCT |mcontext64|)))
 (SB-ALIEN:DEFINE-ALIEN-TYPE |mcontext64_t|
                             (COMMON-LISP:* (SB-ALIEN:STRUCT |mcontext64|)))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |mcontext| (SB-ALIEN:STRUCT |mcontext|))) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_mcontext_t|
                             (COMMON-LISP:* (SB-ALIEN:STRUCT |mcontext|)))
 (SB-ALIEN:DEFINE-ALIEN-TYPE |mcontext_t|
                             (COMMON-LISP:* (SB-ALIEN:STRUCT |mcontext|)))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |sigcontext|
                            (SB-ALIEN:STRUCT |sigcontext|
                                             (|sc_onstack| SB-ALIEN:INT
                                                           :ALIGNMENT
                                                           8)
                                             (|sc_mask| SB-ALIEN:INT
                                                        :ALIGNMENT
                                                        32)
                                             (|sc_eax| SB-ALIEN:UNSIGNED-INT
                                                       :ALIGNMENT
                                                       64)
                                             (|sc_ebx| SB-ALIEN:UNSIGNED-INT
                                                       :ALIGNMENT
                                                       32)
                                             (|sc_ecx| SB-ALIEN:UNSIGNED-INT
                                                       :ALIGNMENT
                                                       64)
                                             (|sc_edx| SB-ALIEN:UNSIGNED-INT
                                                       :ALIGNMENT
                                                       32)
                                             (|sc_edi| SB-ALIEN:UNSIGNED-INT
                                                       :ALIGNMENT
                                                       64)
                                             (|sc_esi| SB-ALIEN:UNSIGNED-INT
                                                       :ALIGNMENT
                                                       32)
                                             (|sc_ebp| SB-ALIEN:UNSIGNED-INT
                                                       :ALIGNMENT
                                                       64)
                                             (|sc_esp| SB-ALIEN:UNSIGNED-INT
                                                       :ALIGNMENT
                                                       32)
                                             (|sc_ss| SB-ALIEN:UNSIGNED-INT
                                                      :ALIGNMENT
                                                      64)
                                             (|sc_eflags| SB-ALIEN:UNSIGNED-INT
                                                          :ALIGNMENT
                                                          32)
                                             (|sc_eip| SB-ALIEN:UNSIGNED-INT
                                                       :ALIGNMENT
                                                       64)
                                             (|sc_cs| SB-ALIEN:UNSIGNED-INT
                                                      :ALIGNMENT
                                                      32)
                                             (|sc_ds| SB-ALIEN:UNSIGNED-INT
                                                      :ALIGNMENT
                                                      64)
                                             (|sc_es| SB-ALIEN:UNSIGNED-INT
                                                      :ALIGNMENT
                                                      32)
                                             (|sc_fs| SB-ALIEN:UNSIGNED-INT
                                                      :ALIGNMENT
                                                      64)
                                             (|sc_gs| SB-ALIEN:UNSIGNED-INT
                                                      :ALIGNMENT
                                                      32))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |sig_atomic_t| SB-ALIEN:INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |ptrdiff_t| SB-ALIEN:INT) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__sputc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__sputc" |__sputc|)
                                SB-ALIEN:INT
                                (|_c| SB-ALIEN:INT)
                                (|_p|
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__swbuf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__swbuf" |__swbuf|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__svfscanf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__svfscanf" |__svfscanf|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |__srget|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("__srget" |__srget|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |funopen|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("funopen" |funopen|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:INT
                                   (COMMON-LISP:* COMMON-LISP:T)
                                   (COMMON-LISP:* COMMON-LISP:CHAR)
                                   SB-ALIEN:INT)))
                                (ARG3
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:INT
                                   (COMMON-LISP:* COMMON-LISP:T)
                                   (COMMON-LISP:* COMMON-LISP:CHAR)
                                   SB-ALIEN:INT)))
                                (ARG4
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION
                                   (COMMON-LISP:INTEGER 64)
                                   (COMMON-LISP:* COMMON-LISP:T)
                                   (COMMON-LISP:INTEGER 64) SB-ALIEN:INT)))
                                (ARG5
                                 (COMMON-LISP:*
                                  (COMMON-LISP:FUNCTION SB-ALIEN:INT
                                   (COMMON-LISP:* COMMON-LISP:T)))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |zopen|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("zopen" |zopen|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |vfscanf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("vfscanf" |vfscanf|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |tempnam|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("tempnam" |tempnam|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |setlinebuf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("setlinebuf" |setlinebuf|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |setbuffer|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("setbuffer" |setbuffer|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |putw|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("putw" |putw|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |putchar_unlocked|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("putchar_unlocked" |putchar_unlocked|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |putc_unlocked|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("putc_unlocked" |putc_unlocked|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |popen|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("popen" |popen|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |pclose|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("pclose" |pclose|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |getw|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("getw" |getw|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |getchar_unlocked|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("getchar_unlocked" |getchar_unlocked|)
                                SB-ALIEN:INT)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |getc_unlocked|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("getc_unlocked" |getc_unlocked|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |funlockfile|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("funlockfile" |funlockfile|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ftrylockfile|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ftrylockfile" |ftrylockfile|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ftello|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ftello" |ftello|)
                                (COMMON-LISP:INTEGER 64)
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fseeko|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fseeko" |fseeko|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (ARG2 (COMMON-LISP:INTEGER 64))
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fpurge|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fpurge" |fpurge|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fmtcheck|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fmtcheck" |fmtcheck|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |flockfile|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("flockfile" |flockfile|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fileno|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fileno" |fileno|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fgetln|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fgetln" |fgetln|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (ARG2 (COMMON-LISP:* SB-ALIEN:UNSIGNED-LONG)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fdopen|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fdopen" |fdopen|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))
                                (ARG1 SB-ALIEN:INT)
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ctermid_r|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ctermid_r" |ctermid_r|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ctermid|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ctermid" |ctermid|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |vasprintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("vasprintf" |vasprintf|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |asprintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("asprintf" |asprintf|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:*
                                  (COMMON-LISP:* COMMON-LISP:CHAR)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |vfprintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("vfprintf" |vfprintf|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ungetc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ungetc" |ungetc|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |tmpnam|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("tmpnam" |tmpnam|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |tmpfile|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("tmpfile" |tmpfile|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |setvbuf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("setvbuf" |setvbuf|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:INT)
                                (ARG4 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |setbuf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("setbuf" |setbuf|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |rewind|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("rewind" |rewind|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |rename|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("rename" |rename|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |remove|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("remove" |remove|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |putc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("putc" |putc|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |perror|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("perror" |perror|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("sys_errlist" |sys_errlist|)
                                (COMMON-LISP:ARRAY
                                 (COMMON-LISP:* COMMON-LISP:CHAR)
                                 1)) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("sys_nerr" |sys_nerr|) SB-ALIEN:INT) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |gets|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("gets" |gets|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |getchar|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("getchar" |getchar|) SB-ALIEN:INT)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |getc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("getc" |getc|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fwrite|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fwrite" |fwrite|)
                                SB-ALIEN:UNSIGNED-LONG
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 SB-ALIEN:UNSIGNED-LONG)
                                (ARG3 SB-ALIEN:UNSIGNED-LONG)
                                (ARG4
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ftell|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ftell" |ftell|)
                                SB-ALIEN:LONG
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fsetpos|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fsetpos" |fsetpos|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (ARG2
                                 (COMMON-LISP:* (COMMON-LISP:INTEGER 64))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fseek|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fseek" |fseek|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (ARG2 SB-ALIEN:LONG)
                                (ARG3 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fscanf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fscanf" |fscanf|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |freopen|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("freopen" |freopen|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fread|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fread" |fread|)
                                SB-ALIEN:UNSIGNED-LONG
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 SB-ALIEN:UNSIGNED-LONG)
                                (ARG3 SB-ALIEN:UNSIGNED-LONG)
                                (ARG4
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fputc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fputc" |fputc|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT)
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fopen|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fopen" |fopen|)
                                (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fgets|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fgets" |fgets|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fgetpos|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fgetpos" |fgetpos|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (ARG2
                                 (COMMON-LISP:* (COMMON-LISP:INTEGER 64))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fgetc|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fgetc" |fgetc|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fflush|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fflush" |fflush|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ferror|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ferror" |ferror|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |feof|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("feof" |feof|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fclose|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fclose" |fclose|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |clearerr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("clearerr" |clearerr|)
                                SB-ALIEN:VOID
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(SB-ALIEN:DEFINE-ALIEN-VARIABLE ("__sF" |__sF|)
                                (COMMON-LISP:ARRAY (SB-ALIEN:STRUCT |__sFILE|)
                                                   1)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__sFILEX| (SB-ALIEN:STRUCT |__sFILEX|)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_wctype_t| SB-ALIEN:UNSIGNED-LONG) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_wctrans_t| SB-ALIEN:INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_nl_item| SB-ALIEN:INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_uuid_t|
                            (COMMON-LISP:ARRAY SB-ALIEN:UNSIGNED-CHAR 16)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_useconds_t| SB-ALIEN:UNSIGNED-INT) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |_opaque_pthread_t|
                             (SB-ALIEN:STRUCT |_opaque_pthread_t|
                                              (|__sig| SB-ALIEN:LONG
                                                       :ALIGNMENT
                                                       8)
                                              (|__cleanup_stack|
                                               (COMMON-LISP:*
                                                (SB-ALIEN:STRUCT
                                                 |__darwin_pthread_handler_rec|))
                                               :ALIGNMENT
                                               32)
                                              (|__opaque|
                                               (COMMON-LISP:ARRAY
                                                COMMON-LISP:CHAR
                                                596)
                                               :ALIGNMENT
                                               64)))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_pthread_t|
                            (COMMON-LISP:*
                             (SB-ALIEN:STRUCT |_opaque_pthread_t|))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |_opaque_pthread_rwlockattr_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_rwlockattr_t|
                                             (|__sig| SB-ALIEN:LONG
                                                      :ALIGNMENT
                                                      8)
                                             (|__opaque|
                                              (COMMON-LISP:ARRAY
                                               COMMON-LISP:CHAR
                                               12)
                                              :ALIGNMENT
                                              32))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_pthread_rwlockattr_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_rwlockattr_t|)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |_opaque_pthread_rwlock_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_rwlock_t|
                                             (|__sig| SB-ALIEN:LONG
                                                      :ALIGNMENT
                                                      8)
                                             (|__opaque|
                                              (COMMON-LISP:ARRAY
                                               COMMON-LISP:CHAR
                                               124)
                                              :ALIGNMENT
                                              32))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_pthread_rwlock_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_rwlock_t|)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |_opaque_pthread_once_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_once_t|
                                             (|__sig| SB-ALIEN:LONG
                                                      :ALIGNMENT
                                                      8)
                                             (|__opaque|
                                              (COMMON-LISP:ARRAY
                                               COMMON-LISP:CHAR
                                               4)
                                              :ALIGNMENT
                                              32))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_pthread_once_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_once_t|)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |_opaque_pthread_mutexattr_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_mutexattr_t|
                                             (|__sig| SB-ALIEN:LONG
                                                      :ALIGNMENT
                                                      8)
                                             (|__opaque|
                                              (COMMON-LISP:ARRAY
                                               COMMON-LISP:CHAR
                                               8)
                                              :ALIGNMENT
                                              32))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_pthread_mutexattr_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_mutexattr_t|)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |_opaque_pthread_mutex_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_mutex_t|
                                             (|__sig| SB-ALIEN:LONG
                                                      :ALIGNMENT
                                                      8)
                                             (|__opaque|
                                              (COMMON-LISP:ARRAY
                                               COMMON-LISP:CHAR
                                               40)
                                              :ALIGNMENT
                                              32))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_pthread_mutex_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_mutex_t|)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_pthread_key_t| SB-ALIEN:UNSIGNED-LONG) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |_opaque_pthread_condattr_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_condattr_t|
                                             (|__sig| SB-ALIEN:LONG
                                                      :ALIGNMENT
                                                      8)
                                             (|__opaque|
                                              (COMMON-LISP:ARRAY
                                               COMMON-LISP:CHAR
                                               4)
                                              :ALIGNMENT
                                              32))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_pthread_condattr_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_condattr_t|)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |_opaque_pthread_cond_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_cond_t|
                                             (|__sig| SB-ALIEN:LONG
                                                      :ALIGNMENT
                                                      8)
                                             (|__opaque|
                                              (COMMON-LISP:ARRAY
                                               COMMON-LISP:CHAR
                                               24)
                                              :ALIGNMENT
                                              32))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_pthread_cond_t|
                            (SB-ALIEN:STRUCT |_opaque_pthread_cond_t|)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:PROGN
  (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_natural_t| SB-ALIEN:UNSIGNED-INT)
  (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_mach_port_name_t|
                              SB-ALIEN:UNSIGNED-INT))
 (SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_mach_port_t| SB-ALIEN:UNSIGNED-INT)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_ino_t| SB-ALIEN:UNSIGNED-INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_gid_t| SB-ALIEN:UNSIGNED-INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_fsfilcnt_t| SB-ALIEN:UNSIGNED-INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_fsblkcnt_t| SB-ALIEN:UNSIGNED-INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_blksize_t| SB-ALIEN:INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_blkcnt_t| (COMMON-LISP:INTEGER 64)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_pthread_handler_rec|
                            (SB-ALIEN:STRUCT |__darwin_pthread_handler_rec|
                                             (|__routine|
                                              (COMMON-LISP:*
                                               (COMMON-LISP:FUNCTION
                                                SB-ALIEN:VOID
                                                (COMMON-LISP:* COMMON-LISP:T)))
                                              :ALIGNMENT
                                              8)
                                             (|__arg|
                                              (COMMON-LISP:* COMMON-LISP:T)
                                              :ALIGNMENT
                                              32)
                                             (|__next|
                                              (COMMON-LISP:*
                                               (SB-ALIEN:STRUCT
                                                |__darwin_pthread_handler_rec|))
                                              :ALIGNMENT
                                              64))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_socklen_t| SB-ALIEN:UNSIGNED-INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_clock_t| SB-ALIEN:UNSIGNED-LONG) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_ptrdiff_t| SB-ALIEN:INT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__mbstate_t|
                            (COMMON-LISP:UNION |__mbstate_t|
                                               (|__mbstate8|
                                                (COMMON-LISP:ARRAY
                                                 COMMON-LISP:CHAR
                                                 128))
                                               (|_mbstateL|
                                                (COMMON-LISP:INTEGER 64)))) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_mbstate_t|
                            (COMMON-LISP:UNION |__mbstate_t|)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__darwin_intptr_t| SB-ALIEN:LONG) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__uint64_t| (COMMON-LISP:INTEGER 64)) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__int16_t| SB-ALIEN:SHORT) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__uint8_t| SB-ALIEN:UNSIGNED-CHAR) 
(SB-ALIEN:DEFINE-ALIEN-TYPE |__int8_t| COMMON-LISP:CHAR) 
(COMMON-LISP:PROGN
 (SB-ALIEN:DEFINE-ALIEN-TYPE |SEXPTYPE_enum|
                             (SB-ALIEN:ENUM COMMON-LISP:NIL
                                            (NILSXP 0)
                                            (SYMSXP 1)
                                            (LISTSXP 2)
                                            (CLOSXP 3)
                                            (ENVSXP 4)
                                            (PROMSXP 5)
                                            (LANGSXP 6)
                                            (SPECIALSXP 7)
                                            (BUILTINSXP 8)
                                            (CHARSXP 9)
                                            (LGLSXP 10)
                                            (INTSXP 13)
                                            (REALSXP 14)
                                            (CPLXSXP 15)
                                            (STRSXP 16)
                                            (DOTSXP 17)
                                            (ANYSXP 18)
                                            (VECSXP 19)
                                            (EXPRSXP 20)
                                            (BCODESXP 21)
                                            (EXTPTRSXP 22)
                                            (WEAKREFSXP 23)
                                            (RAWSXP 24)
                                            (FUNSXP 99)))
 (COMMON-LISP:DEFPARAMETER NILSXP 0)
 (COMMON-LISP:DEFPARAMETER SYMSXP 1)
 (COMMON-LISP:DEFPARAMETER LISTSXP 2)
 (COMMON-LISP:DEFPARAMETER CLOSXP 3)
 (COMMON-LISP:DEFPARAMETER ENVSXP 4)
 (COMMON-LISP:DEFPARAMETER PROMSXP 5)
 (COMMON-LISP:DEFPARAMETER LANGSXP 6)
 (COMMON-LISP:DEFPARAMETER SPECIALSXP 7)
 (COMMON-LISP:DEFPARAMETER BUILTINSXP 8)
 (COMMON-LISP:DEFPARAMETER CHARSXP 9)
 (COMMON-LISP:DEFPARAMETER LGLSXP 10)
 (COMMON-LISP:DEFPARAMETER INTSXP 13)
 (COMMON-LISP:DEFPARAMETER REALSXP 14)
 (COMMON-LISP:DEFPARAMETER CPLXSXP 15)
 (COMMON-LISP:DEFPARAMETER STRSXP 16)
 (COMMON-LISP:DEFPARAMETER DOTSXP 17)
 (COMMON-LISP:DEFPARAMETER ANYSXP 18)
 (COMMON-LISP:DEFPARAMETER VECSXP 19)
 (COMMON-LISP:DEFPARAMETER EXPRSXP 20)
 (COMMON-LISP:DEFPARAMETER BCODESXP 21)
 (COMMON-LISP:DEFPARAMETER EXTPTRSXP 22)
 (COMMON-LISP:DEFPARAMETER WEAKREFSXP 23)
 (COMMON-LISP:DEFPARAMETER RAWSXP 24)
 (COMMON-LISP:DEFPARAMETER FUNSXP 99)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |_Exit|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("_Exit" |_Exit|)
                                SB-ALIEN:VOID
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |exit|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("exit" |exit|)
                                SB-ALIEN:VOID
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |abort|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("abort" |abort|) SB-ALIEN:VOID)) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fprintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fprintf" |fprintf|)
                                SB-ALIEN:INT
                                (ARG1
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|)))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fputs|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fputs" |fputs|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2
                                 (COMMON-LISP:* (SB-ALIEN:STRUCT |__sFILE|))))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |vsprintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("vsprintf" |vsprintf|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |vsnprintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("vsnprintf" |vsnprintf|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 SB-ALIEN:UNSIGNED-LONG)
                                (ARG3 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG4 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |vsscanf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("vsscanf" |vsscanf|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |vscanf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("vscanf" |vscanf|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |vprintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("vprintf" |vprintf|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |sscanf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("sscanf" |sscanf|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |scanf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("scanf" |scanf|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |sprintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("sprintf" |sprintf|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |snprintf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("snprintf" |snprintf|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 SB-ALIEN:UNSIGNED-LONG)
                                (ARG3 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |puts|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("puts" |puts|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |putchar|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("putchar" |putchar|)
                                SB-ALIEN:INT
                                (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |printf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("printf" |printf|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |nanl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("nanl" |nanl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |nanf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("nanf" |nanf|)
                                COMMON-LISP:FLOAT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |nan|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("nan" |nan|)
                                SB-ALIEN:DOUBLE
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |logl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("logl" |logl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |expl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("expl" |expl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cosl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cosl" |cosl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |sinl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("sinl" |sinl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |sqrtl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("sqrtl" |sqrtl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |logf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("logf" |logf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |expf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("expf" |expf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cosf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cosf" |cosf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |sinf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("sinf" |sinf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |sqrtf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("sqrtf" |sqrtf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |log|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("log" |log|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |exp|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("exp" |exp|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |cos|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("cos" |cos|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |sin|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("sin" |sin|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |sqrt|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("sqrt" |sqrt|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strrchr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strrchr" |strrchr|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strchr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strchr" |strchr|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strcspn|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strcspn" |strcspn|)
                                SB-ALIEN:UNSIGNED-LONG
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strspn|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strspn" |strspn|)
                                SB-ALIEN:UNSIGNED-LONG
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strpbrk|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strpbrk" |strpbrk|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strstr|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strstr" |strstr|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strlen|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strlen" |strlen|)
                                SB-ALIEN:UNSIGNED-LONG
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strncmp|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strncmp" |strncmp|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strcmp|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strcmp" |strcmp|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strncpy|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strncpy" |strncpy|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strcpy|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strcpy" |strcpy|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strncat|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strncat" |strncat|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |strcat|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("strcat" |strcat|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:CHAR)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |memset|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("memset" |memset|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 SB-ALIEN:INT)
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |memcmp|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("memcmp" |memcmp|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |memcpy|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("memcpy" |memcpy|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |rindex|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("rindex" |rindex|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |index|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("index" |index|)
                                (COMMON-LISP:* COMMON-LISP:CHAR)
                                (ARG1 (COMMON-LISP:* COMMON-LISP:CHAR))
                                (ARG2 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |ffs|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("ffs" |ffs|) SB-ALIEN:INT (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |bcmp|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("bcmp" |bcmp|)
                                SB-ALIEN:INT
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG3 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |bzero|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("bzero" |bzero|)
                                SB-ALIEN:VOID
                                (ARG1 (COMMON-LISP:* COMMON-LISP:T))
                                (ARG2 SB-ALIEN:UNSIGNED-LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |llabs|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("llabs" |llabs|)
                                (COMMON-LISP:INTEGER 64)
                                (ARG1 (COMMON-LISP:INTEGER 64)))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fabsl|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fabsl" |fabsl|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fabsf|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fabsf" |fabsf|)
                                COMMON-LISP:FLOAT
                                (ARG1 COMMON-LISP:FLOAT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |fabs|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("fabs" |fabs|)
                                SB-ALIEN:DOUBLE
                                (ARG1 SB-ALIEN:DOUBLE))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |labs|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("labs" |labs|)
                                SB-ALIEN:LONG
                                (ARG1 SB-ALIEN:LONG))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |abs|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("abs" |abs|) SB-ALIEN:INT (ARG1 SB-ALIEN:INT))) 
(COMMON-LISP:PROGN
 (COMMON-LISP:DECLAIM (COMMON-LISP:INLINE |alloca|))
 (SB-ALIEN:DEFINE-ALIEN-ROUTINE ("alloca" |alloca|)
                                (COMMON-LISP:* COMMON-LISP:T)
                                (ARG1 SB-ALIEN:UNSIGNED-LONG))) 
