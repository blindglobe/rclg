
setClass("lispIntVectorRef", representation(symbol="character"));

setMethod("[[", "lispIntVectorRef",
   function(x, i, j, ...) { 3 }
          )
new("lispIntVectorRef")


