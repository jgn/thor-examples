class Ex < Thor
  include Thor::Actions

  def self.source_root
    File.dirname(__FILE__)
  end

  desc "create", "create"
  def create
    # parameters
    # destination
    # data (can be a block)
    # config, e.g., :verbose => false
    create_file "doc/config.rb", "boo", verbose: false
  end

  desc "create-force", "create but force it"
  def create_force
    content=<<~EOF
      __start__
      README
      __end__
    EOF
    create_file "doc/README", content, force: true
  end

  desc "append-after", "append to a file after a match"
  def append_after
    # behavior: Does not inject if the content exists anywhere in the file
    inject_into_file "doc/README", "\nmore content", after: "__start__"
  end

  desc "prepend-before", "prepend to a file before a match"
  def prepend_before
    # behavior: Does not inject if the content exists *anywhere* in the file
    inject_into_file "doc/README", "more content\n", before: "__end__"
  end

  desc "prepend-before-capture", "prepend to a file before a match, with regexp"
  def prepend_before_capture
    # Notice that the regexp can use a capture, but it's unclear from the
    # Thor source why you'd want a capture or how you would obtain the result
    inject_into_file "doc/README", "more content\n", before: /(__end__)/
  end

  desc "append", "append to end of file"
  def append
    # behavior: Append if no :after or :before specified
    inject_into_file "doc/README", "more content\n"
  end

  desc "revoke", "prepend before match, and then revoke"
  def revoke
    inject_into_file "doc/README", "more content\n", :before => "__end__"
    self.behavior = :revoke
    inject_into_file "doc/README", "more content\n", :before => "__end__"
  end

  # other parameters
  #  :pretend => true       # Run but do not make any changes
  #  :force => true         # Overwrite files that already exist
  #  :quiet => true         # Suppress status output
  #  :skip => true          # Skip files that already exist
end
