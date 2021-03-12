function slicematrix(A::AbstractMatrix{T}) where T
           m, n = size(A)
           B = Vector{T}[Vector{T}(undef, n) for _ in 1:m]
           for i in 1:m
               B[i] .= A[i, :]
           end
           return B
end
