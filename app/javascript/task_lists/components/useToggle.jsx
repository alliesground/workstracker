import React, { useState } from 'react';

export const useToggle = (init=false) => {

  const [isOpen, setIsOpen] = useState(init);

  const handleOpen = () => setIsOpen(true);
  const handleClose = () => setIsOpen(false);

  return [isOpen, handleOpen, handleClose];
}
