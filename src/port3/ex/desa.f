C$TEST DESA
C TO RUN AS A MAIN PROGRAM REMOVE NEXT LINE
      SUBROUTINE DESA
C***********************************************************************
C
C  EXAMPLE OF USE OF THE PORT PROGRAM ODES
C
C***********************************************************************
      EXTERNAL EQNS, PRINT
      COMMON /NMBR/NMFNS
      COMMON /DATA/ERRPAR,DT,X,TSTART
C
      INTEGER KASE,NMFNS
      REAL X(2),DX,DT,TSTART
      REAL ERRPAR(2)
C
      DO 1 KASE=1,3
      X(1) = 1.E0
      X(2) = -1.E0
      CALL CASE(KASE)
C
      CALL ODES (EQNS, X, 2, TSTART, 2.0E0, DT, ERRPAR, PRINT)
C
    1 CONTINUE
C
      STOP
      END
      SUBROUTINE EQNS (T, X, N, DX)
      COMMON /NMBR/NMFNS
C
      INTEGER NMFNS,N
      REAL T,X(2),DX(2)
C
      DX(1) = X(2)
      DX(2) = X(1)
      NMFNS = NMFNS + 1
C
      RETURN
      END
      SUBROUTINE CASE(KASE)
      COMMON /NMBR/NMFNS
      COMMON /DATA/ERRPAR,DT,X,TSTART
C
      INTEGER IWRITE,I1MACH,NMFNS,KASE
      REAL X(2),DT,TSTART
      REAL ERRPAR(2)
C
      IWRITE = I1MACH(2)
      NMFNS = 0
      TSTART = 0.0E0
      GO TO (10, 20, 30), KASE
C
C  SET UP CASE 1
   10 ERRPAR(1) = 1.E-2
      ERRPAR(2) = 1.E-3
      DT = 1.E0
      GO TO 40
C
C  SET UP CASE 2
   20 ERRPAR(1) = 1.E-4
      ERRPAR(2) = 1.E-6
      DT = 1.E-7
      GO TO 40
C
C  SET UP CASE 3
   30 ERRPAR(1) = 1.E-4
      ERRPAR(2) = 1.E-6
      DT = 1.E0
C
C  WRITE OUT ERRPAR AND DT
   40 WRITE (IWRITE, 9997) ERRPAR(1), ERRPAR(2), DT
 9997 FORMAT(15X,28H FOR THE VALUES, ERRPAR(1) =, 1PE9.2,
     *   16H AND ERRPAR(2) =,1PE9.2  //16X,22HWITH INITIAL DT SET TO,
     *   1PE10.2//)
C
C  WRITE OUT COLUMN HEADINGS FOR THE SOLUTION
      WRITE (IWRITE,9998)
 9998 FORMAT(12X, 5H TIME,14X, 5H X(1),15X, 5H X(2),14X, 3H DT//)
C
C  WRITE OUT THE INITIAL VALUES OF T AND X
      WRITE (IWRITE,9999) TSTART, X(1), X(2), DT
 9999 FORMAT(2X,1P3E20.8,1PE14.2)
C
      RETURN
      END
      SUBROUTINE PRINT (T0, X0, T1, X1, N, DT, TSTOP, E)
      COMMON /NMBR/NMFNS
C
      INTEGER IWRITE,I1MACH,N,NMFNS
      REAL T0,X0(N),T1,X1(N),DT,TSTOP,E(N)
C
      IF(T0 .EQ. T1) RETURN
C
      IWRITE = I1MACH(2)
      WRITE (IWRITE,9998) T1,X1(1),X1(2),DT
 9998 FORMAT (2X,1P3E20.8,1PE14.2)
C
      IF (T1 .LT. TSTOP) RETURN
C
      WRITE (IWRITE,9999) NMFNS
 9999 FORMAT (1H0,15X,  39H THE NUMBER OF FUNCTION EVALUATIONS WAS,I4)
C
      RETURN
C
      END
