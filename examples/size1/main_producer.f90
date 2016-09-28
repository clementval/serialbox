PROGRAM main_producer
  IMPLICIT NONE
  REAL(KIND=8), DIMENSION(1,256) :: a
  INTEGER :: i
 
  DO i = 1, 256
    a(1,i) = 10
  END DO

  PRINT *, 'CALL serialize with sum(a)=', sum(a)

  !$ser init directory='.' prefix='SerialboxTest'
  !$ser savepoint sp1
  !$ser mode write
  !$ser data ser_a=a

END PROGRAM main_producer
