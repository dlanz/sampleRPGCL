      *%METADATA                                                       *
      * %TEXT Multiplies two numbers                                   *
      *%EMETADATA                                                      *
        ctl-opt NoMain;

        dcl-proc multnum EXPORT;

          // Procedure Interface Definition for multnum
          /define multnum_pi
          /include 'QPROTOTYPE/multnum.rpgleinc'

          Dcl-s result                  packed(5:0)     inz(0);
          Dcl-s wField1                 packed(5:0)     inz(0);
          Dcl-s wField2                 packed(5:0)     inz(0);

          wField1 = pValue1;
          wField2 = pValue2;
          result = wField1 * wField2;

          return result;

          *InLR = *on;
        End-Proc multnum;