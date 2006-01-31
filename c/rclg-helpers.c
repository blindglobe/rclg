#include <R.h>
#include <Rinternals.h>

void doubleFloatVecToR(double *d, int length, SEXP v) {
  int i;

  for (i = 0; i < length; i++) {
    SEXP tmp = Rf_allocVector(REALSXP, 1);
    double *tmpptr = REAL(tmp);
    *tmpptr = d[i];
    SET_VECTOR_ELT(v, i, tmp);
  }
}

/* We use the divisor to handle the fact that CMUCL fixnums are *4. */
/* May not work in other CLs. */
void intVecToR(int *d, int length, SEXP v, int divisor) {
  int i;

  for (i = 0; i < length; i++) {
    SEXP tmp = Rf_allocVector(INTSXP, 1);
    int *tmpptr = INTEGER(tmp);
    *tmpptr = d[i]/divisor;
    SET_VECTOR_ELT(v, i, tmp);
  }
}
