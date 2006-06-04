#include <R.h>
#include <Rinternals.h>
#include <Rdefines.h>

extern int Rf_initEmbeddedR(int argc, char *argv[]);

int main(int argc, char **argv) {
  SEXP inst, fun;
  Rf_initEmbeddedR(argc, argv);
  inst = Rf_install("rnorm");
  printf("install=%d\n", install);
  fun = Rf_findFun(inst, R_GlobalEnv);
  printf("fun=%d, unbound=%d\n", fun, R_UnboundValue);
}
