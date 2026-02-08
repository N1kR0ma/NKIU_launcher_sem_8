function mass_length = mass_lenght_function(varargin)
    mass_length = zeros(1, length(varargin));
    
    for i = 1:length(varargin)
        % Используем numel для подсчета общего числа элементов
        mass_length(i) = numel(varargin{i});
    end
end