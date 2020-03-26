function PrintHamilton(graph)

nrows = size(graph,1);
string = zeros(nrows*3);

one = [0,0,0;1,1,1;0,0,0];
two = [0,1,0;0,1,0;0,1,0];
three = [0,0,0;1,1,0;0,1,0];
four = [0,1,0;1,1,0;0,0,0];
five = [0,0,0;0,1,1;0,1,0];
six = [0,1,0;0,1,1;0,0,0];

for ii = 1:nrows
    for jj = 1:nrows
        if jj~=1 && jj~=nrows
            if Consecutive(graph(ii, jj-1), graph(ii, jj), graph(ii, jj+1))
                string((ii-1)*3+1:ii*3, (jj-1)*3+1:jj*3) = one;
            end
        end
        if ii>1 && ii<nrows
            if Consecutive(graph(ii-1, jj), graph(ii, jj), graph(ii+1,jj))
                string((ii-1)*3+1:ii*3, (jj-1)*3+1:jj*3) = two;
            end
        end
        if jj>1 && ii<nrows
            if Consecutive(graph(ii,jj-1), graph(ii, jj), graph(ii+1, jj))
                string((ii-1)*3+1:ii*3, (jj-1)*3+1:jj*3) = three;
            end
        end
        if ii>1 && jj>1
            if Consecutive(graph(ii-1, jj), graph(ii, jj), graph(ii, jj-1))
                string((ii-1)*3+1:ii*3, (jj-1)*3+1:jj*3) = four;
            end
        end
        if ii<nrows & jj<nrows
            if Consecutive(graph(ii, jj+1), graph(ii, jj), graph(ii+1, jj))
                string((ii-1)*3+1:ii*3, (jj-1)*3+1:jj*3) = five;
            end
        end
        if ii>1 && jj<nrows
            if Consecutive(graph(ii-1, jj), graph(ii, jj), graph(ii, jj+1))
                string((ii-1)*3+1:ii*3, (jj-1)*3+1:jj*3) = six;
            end
        end
    end
end

imshow(imresize(string,30, 'Nearest'));
end

function check = Consecutive(a,b,c)
if a+1==b &&b+1==c
    check = true;
elseif c+1==b && b+1==a
    check = true;
else
    check = false;
end
end
