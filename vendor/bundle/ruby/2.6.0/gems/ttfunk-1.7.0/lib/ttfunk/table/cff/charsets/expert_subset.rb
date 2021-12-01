# frozen_string_literal: true

module TTFunk
  class Table
    class Cff < TTFunk::Table
      module Charsets
        EXPERT_SUBSET = OneBasedArray.new(
          [
            'space',
            *[nil] * 11,
            'comma',
            'hyphen',
            'period',
            *[nil] * 11,
            'colon',
            'semicolon',
            *[nil] * 70,
            'fraction',
            *[nil] * 9,
            'fi',
            'fl',
            *[nil] * 39,
            'onesuperior',
            *[nil] * 4,
            'onehalf',
            nil,
            nil,
            'onequarter',
            *[nil] * 4,
            'threequarters',
            'twosuperior',
            *[nil] * 4,
            'threesuperior',
            *[nil] * 61,
            'dollaroldstyle',
            'dollarsuperior',
            nil,
            nil,
            'parenleftsuperior',
            'parenrightsuperior',
            'twodotenleader',
            'onedotenleader',
            'zerooldstyle',
            'oneoldstyle',
            'twooldstyle',
            'threeoldstyle',
            'fouroldstyle',
            'fiveoldstyle',
            'sixoldstyle',
            'sevenoldstyle',
            'eightoldstyle',
            'nineoldstyle',
            'commasuperior',
            'threequartersemdash',
            'periodsuperior',
            nil,
            'asuperior',
            'bsuperior',
            'centsuperior',
            'dsuperior',
            'esuperior',
            'isuperior',
            'lsuperior',
            'msuperior',
            'nsuperior',
            'osuperior',
            'rsuperior',
            'ssuperior',
            'tsuperior',
            'ff',
            'ffi',
            'ffl',
            'parenleftinferior',
            'parenrightinferior',
            nil,
            'hyphensuperior',
            *[nil] * 27,
            'colonmonetary',
            'onefitted',
            'rupiah',
            nil,
            nil,
            'centoldstyle',
            *[nil] * 8,
            'figuredash',
            'hypheninferior',
            *[nil] * 4,
            'oneeighth',
            'threeeighths',
            'fiveeighths',
            'seveneighths',
            'onethird',
            'twothirds',
            'zerosuperior',
            'foursuperior',
            'fivesuperior',
            'sixsuperior',
            'sevensuperior',
            'eightsuperior',
            'ninesuperior',
            'zeroinferior',
            'oneinferior',
            'twoinferior',
            'threeinferior',
            'fourinferior',
            'fiveinferior',
            'sixinferior',
            'seveninferior',
            'eightinferior',
            'nineinferior',
            'centinferior',
            'dollarinferior',
            'periodinferior'
          ]
        ).freeze
      end
    end
  end
end
