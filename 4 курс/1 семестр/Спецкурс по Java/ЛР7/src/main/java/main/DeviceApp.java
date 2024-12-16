package main;

import main.model.Computer;
import main.model.ElectronicDevice;
import main.model.Smartphone;

import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class DeviceApp extends JFrame {
    private List<ElectronicDevice> deviceCollection;
    private JPanel mainPanel;
    private JScrollPane scrollPane;

    public DeviceApp() {
        deviceCollection = new ArrayList<>();
        setTitle("Просмотр электронных устройств");
        setSize(800, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JMenuBar menuBar = new JMenuBar();
        JMenu fileMenu = new JMenu("Файл");
        JMenuItem loadMenuItem = new JMenuItem("Загрузить из файла...");
        JMenuItem autoFillMenuItem = new JMenuItem("Автоматическое заполнение");

        loadMenuItem.addActionListener(new LoadActionListener());
        autoFillMenuItem.addActionListener(new AutoFillActionListener());

        fileMenu.add(loadMenuItem);
        fileMenu.add(autoFillMenuItem);
        menuBar.add(fileMenu);

        setJMenuBar(menuBar);

        mainPanel = new JPanel();
        mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));
        scrollPane = new JScrollPane(mainPanel);
        scrollPane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_AS_NEEDED);
        scrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);

        add(scrollPane, BorderLayout.CENTER);

        JMenu viewMenu = new JMenu("Вид");
        JRadioButtonMenuItem metalItem = new JRadioButtonMenuItem("Metal");
        JRadioButtonMenuItem nimbusItem = new JRadioButtonMenuItem("Nimbus");
        JRadioButtonMenuItem windowsItem = new JRadioButtonMenuItem("Windows");

        ButtonGroup group = new ButtonGroup();
        group.add(metalItem);
        group.add(nimbusItem);
        group.add(windowsItem);

        metalItem.setSelected(true);

        metalItem.addActionListener(new PLaFActionListener("javax.swing.plaf.metal.MetalLookAndFeel"));
        nimbusItem.addActionListener(new PLaFActionListener("javax.swing.plaf.nimbus.NimbusLookAndFeel"));
        windowsItem.addActionListener(new PLaFActionListener("com.sun.java.swing.plaf.windows.WindowsLookAndFeel"));

        viewMenu.add(metalItem);
        viewMenu.add(nimbusItem);
        viewMenu.add(windowsItem);
        menuBar.add(viewMenu);
    }

    private class PLaFActionListener implements ActionListener {
        private String plafClassName;

        public PLaFActionListener(String plafClassName) {
            this.plafClassName = plafClassName;
        }

        @Override
        public void actionPerformed(ActionEvent e) {
            try {
                UIManager.setLookAndFeel(plafClassName);
                SwingUtilities.updateComponentTreeUI(DeviceApp.this);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void loadDeviceCollectionFromFile(File file) {
        deviceCollection.clear();
        try (InputStream in = new FileInputStream(file.getAbsoluteFile())) {
            String extension = getFileExtension(file);
            if ("ser".equalsIgnoreCase(extension)) {
                while (in.available() > 0) {
                    deviceCollection.add(DeviceIO.deserializeElectronicDevice(in));
                }
            } else if ("dat".equalsIgnoreCase(extension)) {
                while (in.available() > 0) {
                    deviceCollection.add(DeviceIO.inputElectronicDevice(in));
                }
            } else if ("txt".equalsIgnoreCase(extension)) {
                try (FileReader reader = new FileReader(file)) {
                    deviceCollection.addAll(DeviceIO.readElectronicDevice(reader));
                }
            }
            displayDeviceCollection();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void autoFillDeviceCollection() {
        deviceCollection.clear();

        // Smartphone data
        String[] smartphoneApps = {"Social Media", "Games", "Browser", "Email"};
        String smartphoneModel = "Galaxy S23 Ultra";
        int smartphoneStorageGB = 256;
        Smartphone smartphone = new Smartphone(smartphoneApps, smartphoneModel, smartphoneStorageGB);

        // Computer data
        String[] computerComponents = {"Intel Core i7", "16GB RAM", "1TB SSD", "NVIDIA RTX 3070"};
        String computerModel = "Alienware Aurora R15";
        int computerStorageGB = 2000; // Assuming 2TB storage
        Computer computer = new Computer(computerComponents, computerModel, computerStorageGB);

        deviceCollection.add(smartphone);
        deviceCollection.add(computer);
        displayDeviceCollection();
    }


    private void displayDeviceCollection() {
        mainPanel.removeAll();
        for (int i = 0; i < deviceCollection.size(); i++) {
            ElectronicDevice device = deviceCollection.get(i);
            JPanel panel = new JPanel();
            panel.setBorder(BorderFactory.createTitledBorder(device.getModel() + " (" + device.getClass().getSimpleName() + ")"));
            panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));

            panel.setAlignmentX(Component.LEFT_ALIGNMENT);
            panel.setMaximumSize(new Dimension(Integer.MAX_VALUE, Integer.MAX_VALUE));

            String[] componentsOrApps = device.getComponentsOrApps();
            for (String component : componentsOrApps) {
                panel.add(new JLabel(component));
            }
            panel.addMouseListener(new DeviceMouseListener(i, device));
            mainPanel.add(panel);
        }
        mainPanel.revalidate();
        mainPanel.repaint();
    }

    private class LoadActionListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            JFileChooser fileChooser = new JFileChooser();
            fileChooser.setFileFilter(new FileNameExtensionFilter("Supported file types", "ser", "dat", "txt"));
            int result = fileChooser.showOpenDialog(DeviceApp.this);
            if (result == JFileChooser.APPROVE_OPTION) {
                File selectedFile = fileChooser.getSelectedFile();
                loadDeviceCollectionFromFile(selectedFile);
            }
        }
    }

    private class AutoFillActionListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            autoFillDeviceCollection();
        }
    }

    private class DeviceMouseListener extends java.awt.event.MouseAdapter {
        private int index;
        private ElectronicDevice device;

        public DeviceMouseListener(int index, ElectronicDevice device) {
            this.index = index;
            this.device = device;
        }

        @Override
        public void mouseClicked(java.awt.event.MouseEvent e) {
            String message = "Элемент #" + (index + 1) + "\n" + device.toString();
            JOptionPane.showMessageDialog(DeviceApp.this, message, "Детальный просмотр устройства", JOptionPane.INFORMATION_MESSAGE);
        }
    }

    private String getFileExtension(File file) {
        String name = file.getName();
        int lastIndexOf = name.lastIndexOf(".");
        if (lastIndexOf == -1) {
            return ""; // empty extension
        }
        return name.substring(lastIndexOf + 1);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            DeviceApp app = new DeviceApp();
            app.setVisible(true);
        });
    }
}