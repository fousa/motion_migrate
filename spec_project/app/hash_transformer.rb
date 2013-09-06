class HashTransformer
  class << self
    def allowsReverseTransformation
      true
    end

    def transformedValueClass
      NSData
    end
  end

  def transformedValue(value)
    NSKeyedArchiver.archivedDataWithRootObject(value)
  end

  def reverseTransformedValue(value)
    NSKeyedUnarchiver.unarchiveObjectWithData(value)
  end
end

