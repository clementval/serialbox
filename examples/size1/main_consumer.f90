PROGRAM main_consumer
  IMPLICIT NONE
  REAL(KIND=8), DIMENSION(1,256) :: a

  a(1,:) = 0.0

  PRINT*,'Before read from serializer: sum(a)=', sum(a)

  !$ser init directory='.' prefix='SerialboxTest-output' prefix_ref='SerialboxTest'
  !$ser savepoint sp1
  !$ser mode read
  !$ser data ser_a=a
  !$ser mode write
  !$ser data ser_a=a

  PRINT*,'After read from serializer: sum(a)=', sum(a)
END PROGRAM main_consumer
