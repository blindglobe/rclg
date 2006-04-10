
#include <stdio.h>
#include <R.h>
#include <Rinternals.h>
#include <R_ext/Parse.h>

/* These are some useless test functions */

unsigned int test_sexp_type (SEXP obj) {
  return TYPEOF(obj);
}

char* test_sexp_string  (SEXP obj) {
  return CHAR(STRING_ELT(obj,0));
}

void test_me() {
  printf("bogus!\n");
}
