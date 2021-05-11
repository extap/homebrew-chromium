
class DepotTools < Formula
  desc "Collection of tools for dealing with Chromium development"
  homepage "https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools.html"
  url "https://chromium.googlesource.com/chromium/tools/depot_tools.git",
    :branch => "master"
  version "master"

  def tools
    %w[
      gclient
      gcl
      fetch
      git-cl
      hammer
      drover
      cpplint.py
      presubmit_support.py
      trychange.py
      git-try
      wtf
      weekly
      git-gs
      zsh-goodies
      ninja
    ]
  end

  def install
    prefix.install Dir["*"]
    bin.mkpath

    tools.each do |tool|
      (bin/tool).write <<~EOS
        #!/bin/bash
        TOOL=#{prefix}/#{tool}
        export DEPOT_TOOLS_UPDATE=0
        export PATH="$PATH:#{prefix}"
        exec "$TOOL" "$@"
      EOS
    end
  end

  def caveats
    <<~EOS
    Installed tools:
    #{tools.join(", ")}
    EOS
  end

  test do
    %w[fetch gclient trychange.py].each do |tool|
      system "#{bin}/#{tool}", "--version"
    end
  end
end
