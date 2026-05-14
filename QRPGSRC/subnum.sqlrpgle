      *%METADATA                                                       *
      * %TEXT Subtracts two numbers                                    *
      *%EMETADATA                                                      *
        ctl-opt NoMain;

        dcl-proc subnum EXPORT;

          // Prototype Definition for subnum
          /define subnum_pr
          /copy 'QPROTOTYPE/subnum.rpgleinc'

          // Procedure Interface Definition for subnum
          /define subnum_pi
          /include 'QPROTOTYPE/subnum.rpgleinc'

          Dcl-s result                  packed(5:0)     inz(0);
          Dcl-s wField1                 packed(5:0)     inz(0);
          Dcl-s wField2                 packed(5:0)     inz(0);

          wField1 = pValue1;
          wField2 = pValue2;
          result = wField1 - wField2;

          return result;

          *InLR = *on;
        End-Proc subnum;
