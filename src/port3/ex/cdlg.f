C$TEST CDLG
C TO RUN AS A MAIN PROGRAM REMOVE NEXT LINE
      SUBROUTINE CDLG
C***********************************************************************
C
C  EXAMPLE OF USE OF THE PORT PROGRAM CDLOG
C
C***********************************************************************
      DOUBLE PRECISION A(2),LOG(2)
      IWRITE = I1MACH(2)
C
      A(1) = 2.D0
      A(2) = -1.D0
      CALL CDLOG(A,LOG)
C
      WRITE(IWRITE,9999) A, LOG
 9999 FORMAT (13H THE LOG OF (,1PD10.4,2H, ,1PD11.4,8H) IS    //
     1           4H   (,1PD24.18,2H, ,1PD25.18,1H))
C
      STOP
      END
