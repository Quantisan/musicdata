users = csvread("/Users/paullam/Dropbox/Projects/musicdata/data/users.csv");  ## couldn't get getcwd() working
train = csvread("/Users/paullam/Dropbox/Projects/musicdata/data/train.csv");
#words = csvread("/Users/paullam/Dropbox/Projects/musicdata/data/words.csv");  ## 20mb, index out of range error

## debugging datafmt/dlmread

fname = "/Users/paullam/Dropbox/Projects/musicdata/data/words.csv";
dlm = ',';
eol = '\n';
#function dlmread(fname::String, dlm, eol::Char)
(io, nr, nc, row) = _jl_dlmread_setup(fname, dlm, eol)
a = Array(Float64, nr, nc)
a = _jl_dlmread_auto2(a, io, dlm, nr, nc, row, eol)
close(io)

_jl_dlmread2(a::Array{Any}, io, dlm, nr, nc, row, eol) =
    _jl_dlmread2(a, io, dlm, nr, nc, row, eol, 1, 1)
function _jl_dlmread2(a::Array{Any}, io, dlm, nr, nc, row, eol, i0, j0)
    tmp = Array(Float64,1)
    j = j0
    for i=i0:nr
        while j <= nc
            el = row[j]  ## exception
            if float64_isvalid(el, tmp)
                a[i,j] = tmp[1]
            else
                a[i,j] = el
            end
            j += 1
        end
        j = 1
        if i < nr
            row = _jl_dlm_readrow(io, dlm, eol)
        end
    end
    a
end

# float64 or cell depending on data
function _jl_dlmread_auto2(a, io, dlm, nr, nc, row, eol)
    tmp = Array(Float64, 1)
    for i=1:nr
        for j=1:nc
            el = row[j]
            if !float64_isvalid(el, tmp)
                a = convert(Array{Any,2}, a)
                _jl_dlmread2(a, io, dlm, nr, nc, row, eol, i, j)  ## exception
                return a
            else
                a[i,j] = tmp[1]
            end
        end
        if i < nr
            row = _jl_dlm_readrow(io, dlm, eol)
        end
    end
    a
end
