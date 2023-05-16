class Module
  def parent_of(mod)
    parent_name = mod.name =~ /::[^:]+\Z/ ? $`.freeze : nil
    Object.const_get(parent_name) if parent_name
  end

  def all_modules
    [self] + constants.map { |c| const_get(c) }
                      .select { |c| c.is_a?(Module) && parent_of(c) == self }
                      .flat_map { |m| m.all_modules }
                      .select { |c| c.is_a?(Class) }
  end
end

