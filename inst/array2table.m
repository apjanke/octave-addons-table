function out = array2table(c, varargin)
  %CELL2TABLE Convert a cell array to a table

  if ndims (c) > 2
    error ('Input must be 2-D; got %d-D', ndims (c));
  endif
  
  % Peel off trailing options
  knownOpts = {'VariableNames', 'RowNames'};
  opts = struct;
  args = varargin;
  while numel (args) >= 2 && ismember (args{end-1}, knownOpts)
    opts.(args{end-1}) = args{end};
    args(end-1:end) = [];
  end
  if ~isempty (args)
    error ('Unrecognized options');
  endif

  nCols = size (c, 2);
  colVals = cell (1, nCols);
  for iCol = 1:nCols
    colVals{iCol} = c(:,iCol);
  endfor
  
  if isfield (opts, 'VariableNames')
    varNames = opts.VariableNames;
  else
    varNames = cell (1, nCols);
    for iCol = 1:nCols
      varNames{iCol} = sprintf('Var%d', iCol);
    endfor
  endif
  
  optArgs = {'VariableNames', varNames};
  if isfield (opts, 'RowNames')
    optArgs = [optArgs {'RowNames', opts.RowNames}];
  endif
  out = table (colVals{:}, optArgs{:});  
endfunction