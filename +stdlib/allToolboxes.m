%% ALLTOOLBOXES tell all the Matlab toolboxes known for this Matlab release
% requires: java

function names = allToolboxes()

tbx = com.mathworks.product.util.ProductIdentifier.values; %#ok<JAPIMATHWORKS>

names = table(Size=[numel(tbx), 2], VariableTypes=["string", "string"], VariableNames=["product", "license"]);

names.product = string(tbx);

for i = 1:numel(tbx)
  names.license(i) = tbx(i).getFlexName().string;
end

names = sortrows(names);

end