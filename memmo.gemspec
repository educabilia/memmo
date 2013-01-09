require File.expand_path("lib/memmo/version", File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name              = "memmo"
  s.version           = Memmo::VERSION
  s.summary           = "In-memory, thread-safe caches supporting time-to-live."
  s.authors           = ["Educabilia", "Damian Janowski"]
  s.email             = ["opensource@educabilia.com", "djanowski@dimaion.com"]
  s.homepage          = "https://github.com/educabilia/memmo"

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- {test}/*`.split("\n")
end
