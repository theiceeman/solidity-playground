const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("Mars", function () {
  before(async () => {
    Mars = await ethers.getContractFactory("Mars");
    MarsV2 = await ethers.getContractFactory("MarsV2");

    let mars, marsv2;
  });
  it("should deploy Mars token", async function () {
    mars = await upgrades.deployProxy(Mars, { kind: "uups" });
    await mars.deployed();

    expect(await mars.name()).to.equal("Mars");
  });
  it("should upgrade Marsv1 to Marsv2", async function () {
    marsv2 = await upgrades.upgradeProxy(mars, MarsV2, { kind: "uups" });
    expect(await marsv2.version()).to.equal("V2");
  });
});
