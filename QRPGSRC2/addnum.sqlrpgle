      *%METADATA                                                       *
      * %TEXT Adds two numbers                                         *
      *%EMETADATA                                                      *
        ctl-opt NoMain;

        dcl-proc addnum EXPORT;

          // Procedure Interface Definition for addnum
          /define addnum_pi
          /include 'QPROTOTYPE/addnum.rpgleinc'

          Dcl-s result                  packed(5:0)     inz(0);
          Dcl-s wField1                 packed(5:0)     inz(0);
          Dcl-s wField2                 packed(5:0)     inz(0);

          wField1 = pValue1;
          wField2 = pValue2;
          result = wField1 + wField2;

          return result;

          *InLR = *on;
        End-Proc addnum;