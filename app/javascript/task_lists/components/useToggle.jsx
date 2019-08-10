import React, { useState } from 'react';

export const useToggle = (init=false) => {

  const [val, toggleVal] = useState(init);

  const toggle = () => toggleVal(!val);

  return [val, toggle];
}
