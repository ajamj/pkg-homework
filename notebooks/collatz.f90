subroutine fortran_collatz_conjecture(n, sequence, length)
    implicit none
    integer, intent(in) :: n
    integer, intent(out) :: sequence(1000000)
    integer, intent(out) :: length
    integer :: i, current_value

    i = 1
    current_value = n
    sequence(i) = current_value
    do while (current_value > 1)
        if (mod(current_value, 2) == 0) then
            current_value = current_value / 2
        else
            current_value = 3 * current_value + 1
        end if
        i = i + 1
        sequence(i) = current_value
    end do

    length = i
end subroutine