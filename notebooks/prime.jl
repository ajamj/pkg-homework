function is_prime(x)
    temp = 0
    if x==2 || x==3
        return true
    end
    if x==1
        return false
    end
    for i in range(2,x÷2)
        if (x%i==0)
            temp+=1
        end
    end
    if temp==0
        return true
    else
        return false
    end
end