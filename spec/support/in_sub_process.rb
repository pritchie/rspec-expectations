module InSubProcess
  # Useful as a way to isolate a global change to a subprocess.
  def in_sub_process
    readme, writeme = IO.pipe

    pid = Process.fork do
      # Prevent minitest from autorunning...
      if defined?(::MiniTest::Unit)
        MiniTest::Unit.class_eval do
          def run(*a); end
        end
      end

      value = nil
      begin
        yield
      rescue => e
        value = e
      end

      writeme.write Marshal.dump(value)

      readme.close
      writeme.close
    end

    writeme.close
    Process.waitpid(pid)

    if exception = Marshal.load(readme.read)
      raise exception
    end

    readme.close
  end
end

