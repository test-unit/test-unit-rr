# Copyright (C) 2012-2016  Kouhei Sutou <kou@clear-code.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

class RRTest < Test::Unit::TestCase
  class AssertReceivedTest < self
    def test_success
      subject = Object.new
      stub(subject).should_be_called
      subject.should_be_called
      assert_received(subject) do |_subject|
        _subject.should_be_called
      end
    end

    def test_failure
      subject = Object.new
      stub(subject).should_be_called
      stub(subject).should_not_be_called
      subject.should_be_called
      assert_raise(RR::Errors::SpyVerificationErrors::InvocationCountError) do
        assert_received(subject) do |_subject|
          _subject.should_not_be_called
        end
      end
    end
  end

  class AssertRRTest < self
    def test_success
      subject = Object.new
      assert_rr do
        mock(subject).should_be_called
        subject.should_be_called
      end
    end

    def test_failure
      subject = Object.new
      assert_raise(::RR::Errors::TimesCalledError) do
        assert_rr do
          mock(subject).should_be_called
          # subject.should_be_called
        end
      end
    end
  end
end
